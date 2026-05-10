<?php

/**
 * Backward-compatible RBAC and data-scope foundation.
 *
 * This class is intentionally conservative: legacy user_type checks remain as a
 * fallback while controllers are migrated route by route.
 */
class Rbac
{
    private static $booted = false;
    private static $permissions = [];
    private static $scopeIds = [];

    public static function boot()
    {
        if (self::$booted) {
            return;
        }
        self::$booted = true;

        try {
            self::ensureSchema();
            self::seedLegacyRoles();
            self::seedPermissions();
            self::seedLegacyRolePermissions();
            self::mapLegacyUsers();
            self::backfillUserHierarchy();
            self::backfillOwnership();
        } catch (Throwable $e) {
            // Never break the legacy app because RBAC bootstrap failed.
        } catch (Exception $e) {
            // Never break the legacy app because RBAC bootstrap failed.
        }
    }

    public static function can($permissionKey, $admin = null)
    {
        if (empty($permissionKey)) {
            return false;
        }

        if ($admin === null) {
            $admin = Admin::_info();
        }

        if (empty($admin) || empty($admin['id'])) {
            return false;
        }

        if ($admin['user_type'] == 'SuperAdmin') {
            return true;
        }

        try {
            if (self::hasPermission((int) $admin['id'], $permissionKey)) {
                return true;
            }
            if (self::hasImpliedPermission((int) $admin['id'], $permissionKey)) {
                return true;
            }
            if (self::userHasRoles((int) $admin['id'])) {
                return false;
            }
        } catch (Throwable $e) {
            // Fall through to legacy checks.
        } catch (Exception $e) {
            // Fall through to legacy checks.
        }

        return self::legacyCan($admin, $permissionKey);
    }

    public static function canAny($permissionKeys, $admin = null)
    {
        foreach ((array) $permissionKeys as $permissionKey) {
            if (self::can($permissionKey, $admin)) {
                return true;
            }
        }
        return false;
    }

    public static function canAll($permissionKeys, $admin = null)
    {
        foreach ((array) $permissionKeys as $permissionKey) {
            if (!self::can($permissionKey, $admin)) {
                return false;
            }
        }
        return true;
    }

    public static function getScopeUserIds($admin = null)
    {
        if ($admin === null) {
            $admin = Admin::_info();
        }
        if (empty($admin) || empty($admin['id'])) {
            return [];
        }

        $adminId = (int) $admin['id'];
        if (isset(self::$scopeIds[$adminId])) {
            return self::$scopeIds[$adminId];
        }

        if (!self::isResellerUser($admin) || self::hasGlobalDataScope($admin)) {
            self::$scopeIds[$adminId] = [];
            return [];
        }

        $ids = [$adminId];
        try {
            if (self::tableExists('tbl_user_hierarchy')) {
                $rows = ORM::for_table('tbl_user_hierarchy')
                    ->select('descendant_id')
                    ->where('ancestor_id', $adminId)
                    ->find_array();
                foreach ($rows as $row) {
                    $ids[] = (int) $row['descendant_id'];
                }
            } else {
                $ids = array_merge($ids, self::getDescendantIds($adminId));
            }
        } catch (Throwable $e) {
            // Keep at least self in scope.
        } catch (Exception $e) {
            // Keep at least self in scope.
        }

        self::$scopeIds[$adminId] = array_values(array_unique($ids));
        return self::$scopeIds[$adminId];
    }

    public static function scopeCustomers($query, $admin = null)
    {
        if ($admin === null) {
            $admin = Admin::_info();
        }
        if (empty($admin) || !self::isResellerUser($admin) || self::hasGlobalDataScope($admin)) {
            return $query;
        }

        $scopeIds = self::getScopeUserIds($admin);
        if (empty($scopeIds)) {
            $scopeIds = [(int) $admin['id']];
        }

        try {
            if (self::columnExists('tbl_customers', 'owner_user_id')) {
                $placeholders = implode(',', array_fill(0, count($scopeIds), '?'));
                $params = array_merge($scopeIds, $scopeIds);
                return $query->where_raw("(owner_user_id IN ($placeholders) OR (owner_user_id IS NULL AND created_by IN ($placeholders)))", $params);
            }
        } catch (Throwable $e) {
            // Fallback below.
        } catch (Exception $e) {
            // Fallback below.
        }

        return $query->where_in('created_by', $scopeIds);
    }

    public static function scopeOwned($query, $table, $admin = null, $ownerColumn = 'owner_user_id')
    {
        if ($admin === null) {
            $admin = Admin::_info();
        }
        if (empty($admin) || !self::isResellerUser($admin) || self::hasGlobalDataScope($admin)) {
            return $query;
        }
        if (!self::hasColumn($table, $ownerColumn)) {
            return $query;
        }

        $scopeIds = self::getScopeUserIds($admin);
        if (empty($scopeIds)) {
            $scopeIds = [(int) $admin['id']];
        }

        return $query->where_in($ownerColumn, $scopeIds);
    }

    public static function canAccessCustomer($customerId, $admin = null)
    {
        if ($admin === null) {
            $admin = Admin::_info();
        }
        if (empty($admin) || empty($customerId)) {
            return false;
        }
        if (!self::isResellerUser($admin) || self::hasGlobalDataScope($admin)) {
            return true;
        }

        $customer = ORM::for_table('tbl_customers')->find_one($customerId);
        if (!$customer) {
            return false;
        }

        $scopeIds = self::getScopeUserIds($admin);
        $ownerId = !empty($customer['owner_user_id']) ? (int) $customer['owner_user_id'] : (int) $customer['created_by'];

        return in_array($ownerId, $scopeIds);
    }

    public static function ownerIdFromCustomer($customer)
    {
        if (empty($customer)) {
            return null;
        }
        if (!empty($customer['owner_user_id'])) {
            return (int) $customer['owner_user_id'];
        }
        if (!empty($customer['created_by'])) {
            return (int) $customer['created_by'];
        }
        return null;
    }

    public static function hasGlobalDataScope($admin = null)
    {
        if ($admin === null) {
            $admin = Admin::_info();
        }
        if (empty($admin) || empty($admin['id'])) {
            return false;
        }
        if ($admin['user_type'] == 'SuperAdmin') {
            return true;
        }
        if (!self::isResellerUser($admin)) {
            return true;
        }

        try {
            if (self::hasPermission((int) $admin['id'], 'data.scope.global')) {
                return true;
            }
            if (self::userHasRoles((int) $admin['id'])) {
                return false;
            }
        } catch (Throwable $e) {
            // Fall through to legacy behavior.
        } catch (Exception $e) {
            // Fall through to legacy behavior.
        }

        return $admin['user_type'] == 'Admin';
    }

    public static function isResellerUser($admin = null)
    {
        if ($admin === null) {
            $admin = Admin::_info();
        }
        if (empty($admin) || empty($admin['id'])) {
            return false;
        }

        try {
            $roleId = self::getUserRoleId((int) $admin['id']);
            if ($roleId) {
                $role = self::getRole($roleId);
                return $role && $role['type'] == 'reseller';
            }
        } catch (Throwable $e) {
            // Fall through to legacy check.
        } catch (Exception $e) {
            // Fall through to legacy check.
        }

        return $admin['user_type'] == 'Agent';
    }

    public static function hasColumn($table, $column)
    {
        try {
            return self::columnExists($table, $column);
        } catch (Throwable $e) {
            return false;
        } catch (Exception $e) {
            return false;
        }
    }

    public static function registerPermission($permissionKey, $name = '', $groupName = 'General', $type = 'feature')
    {
        if (empty($permissionKey)) {
            return;
        }

        self::$permissions[$permissionKey] = [
            'name' => $name ?: $permissionKey,
            'group_name' => $groupName,
            'type' => $type,
        ];

        try {
            self::upsertPermission($permissionKey, self::$permissions[$permissionKey]);
        } catch (Throwable $e) {
            // Ignore during bootstrap if tables are not ready.
        } catch (Exception $e) {
            // Ignore during bootstrap if tables are not ready.
        }
    }

    public static function setUserRole($userId, $roleId)
    {
        $userId = (int) $userId;
        $roleId = (int) $roleId;
        if (!$userId || !$roleId) {
            return;
        }

        ORM::for_table('tbl_user_roles')->where('user_id', $userId)->delete_many();
        $row = ORM::for_table('tbl_user_roles')->create();
        $row->user_id = $userId;
        $row->role_id = $roleId;
        $row->save();
    }

    public static function getUserRoleId($userId)
    {
        $rows = ORM::for_table('tbl_user_roles')
            ->table_alias('ur')
            ->select('ur.role_id')
            ->select('r.slug')
            ->inner_join('tbl_roles', ['ur.role_id', '=', 'r.id'], 'r')
            ->where('ur.user_id', $userId)
            ->order_by_desc('r.level')
            ->find_array();

        if (count($rows) == 0) {
            return 0;
        }

        $user = ORM::for_table('tbl_users')->find_one($userId);
        $legacySlug = $user ? strtolower((string) $user['user_type']) : '';
        foreach ($rows as $row) {
            if ($row['slug'] != $legacySlug) {
                return (int) $row['role_id'];
            }
        }

        return (int) $rows[0]['role_id'];
    }

    public static function getAssignableRoles($admin = null)
    {
        if ($admin === null) {
            $admin = Admin::_info();
        }
        $query = ORM::for_table('tbl_roles')->order_by_desc('level')->order_by_asc('name');

        if (empty($admin)) {
            return [];
        }

        if ($admin['user_type'] != 'SuperAdmin' && $admin['user_type'] != 'Admin' && !self::can('resellers.create', $admin)) {
            return [];
        }

        if ($admin['user_type'] != 'SuperAdmin') {
            $query->where_not_equal('slug', 'superadmin');
            $query->where_not_equal('type', 'system');
            $query->where_lte('level', self::actorRoleLevel($admin));
            if ($admin['user_type'] != 'Admin') {
                $query->where('type', 'reseller');
            }
        }

        return $query->find_many();
    }

    public static function canAssignRole($roleId, $admin = null)
    {
        $roleId = (int) $roleId;
        if (!$roleId) {
            return true;
        }
        foreach (self::getAssignableRoles($admin) as $role) {
            if ((int) $role['id'] == $roleId) {
                return true;
            }
        }
        return false;
    }

    public static function getRole($roleId)
    {
        $roleId = (int) $roleId;
        if (!$roleId) {
            return null;
        }
        return ORM::for_table('tbl_roles')->find_one($roleId);
    }

    public static function isResellerRole($roleId)
    {
        $role = self::getRole($roleId);
        return $role && $role['type'] == 'reseller';
    }

    public static function getMaxResellerDepth()
    {
        $setting = ORM::for_table('tbl_appconfig')->where('setting', 'max_reseller_depth')->find_one();
        $depth = $setting ? (int) $setting['value'] : 3;
        return $depth > 0 ? $depth : 3;
    }

    public static function canCreateReseller($admin = null)
    {
        if ($admin === null) {
            $admin = Admin::_info();
        }
        if (empty($admin)) {
            return false;
        }
        if (in_array($admin['user_type'], ['SuperAdmin', 'Admin'])) {
            return true;
        }
        if (!self::can('resellers.create', $admin)) {
            return false;
        }
        return ((int) $admin['reseller_level']) < self::getMaxResellerDepth();
    }

    public static function canAccessAdminUser($targetUserId, $admin = null)
    {
        if ($admin === null) {
            $admin = Admin::_info();
        }
        $targetUserId = (int) $targetUserId;
        if (empty($admin) || !$targetUserId) {
            return false;
        }
        if ((int) $admin['id'] == $targetUserId) {
            return true;
        }
        if ($admin['user_type'] == 'SuperAdmin') {
            return true;
        }
        if ($admin['user_type'] == 'Admin') {
            $target = ORM::for_table('tbl_users')->find_one($targetUserId);
            return $target && in_array($target['user_type'], ['Report', 'Agent', 'Sales']);
        }
        return in_array($targetUserId, self::getScopeUserIds($admin));
    }

    public static function syncUserHierarchy($userId, $parentId = null)
    {
        $userId = (int) $userId;
        $parentId = $parentId ? (int) $parentId : null;
        if (!$userId || !self::tableExists('tbl_user_hierarchy')) {
            return;
        }

        self::syncSingleUserHierarchy($userId, $parentId);

        $children = ORM::for_table('tbl_users')
            ->select('id')
            ->select('parent_id')
            ->where('parent_id', $userId)
            ->find_array();

        foreach ($children as $child) {
            self::syncUserHierarchy($child['id'], $child['parent_id']);
        }
    }

    private static function syncSingleUserHierarchy($userId, $parentId = null)
    {
        $userId = (int) $userId;
        $parentId = $parentId ? (int) $parentId : null;

        ORM::for_table('tbl_user_hierarchy')->where('descendant_id', $userId)->delete_many();

        $self = ORM::for_table('tbl_user_hierarchy')->create();
        $self->ancestor_id = $userId;
        $self->descendant_id = $userId;
        $self->depth = 0;
        $self->save();

        if (!$parentId) {
            return;
        }

        $ancestors = ORM::for_table('tbl_user_hierarchy')
            ->where('descendant_id', $parentId)
            ->find_array();

        foreach ($ancestors as $ancestor) {
            $row = ORM::for_table('tbl_user_hierarchy')->create();
            $row->ancestor_id = $ancestor['ancestor_id'];
            $row->descendant_id = $userId;
            $row->depth = ((int) $ancestor['depth']) + 1;
            $row->save();
        }
    }

    public static function canAssignParent($parentId, $admin = null)
    {
        if (!$parentId) {
            return true;
        }
        if ($admin === null) {
            $admin = Admin::_info();
        }
        if (empty($admin)) {
            return false;
        }
        if (in_array($admin['user_type'], ['SuperAdmin', 'Admin'])) {
            return true;
        }
        return in_array((int) $parentId, self::getScopeUserIds($admin));
    }

    public static function wouldCreateHierarchyCycle($userId, $parentId)
    {
        $userId = (int) $userId;
        $parentId = (int) $parentId;
        if (!$userId || !$parentId) {
            return false;
        }
        if ($userId == $parentId) {
            return true;
        }

        if (self::tableExists('tbl_user_hierarchy')) {
            $row = ORM::for_table('tbl_user_hierarchy')
                ->where('ancestor_id', $userId)
                ->where('descendant_id', $parentId)
                ->find_one();
            if ($row) {
                return true;
            }
        }

        $seen = [$userId];
        $current = $parentId;
        while ($current) {
            if (in_array($current, $seen)) {
                return true;
            }
            $seen[] = $current;
            $parent = ORM::for_table('tbl_users')->select('parent_id')->find_one($current);
            $current = $parent ? (int) $parent['parent_id'] : 0;
        }

        return false;
    }

    private static function actorRoleLevel($admin)
    {
        if (empty($admin)) {
            return 0;
        }

        $roleId = self::getUserRoleId($admin['id']);
        if ($roleId) {
            $role = ORM::for_table('tbl_roles')->find_one($roleId);
            if ($role) {
                return (int) $role['level'];
            }
        }

        $legacyLevels = [
            'SuperAdmin' => 100,
            'Admin' => 90,
            'Agent' => 50,
            'Sales' => 40,
            'Report' => 30,
        ];

        return isset($legacyLevels[$admin['user_type']]) ? $legacyLevels[$admin['user_type']] : 0;
    }

    private static function ensureSchema()
    {
        $db = ORM::get_db();
        $db->exec("CREATE TABLE IF NOT EXISTS tbl_roles (
            id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(100) NOT NULL,
            slug VARCHAR(100) NOT NULL UNIQUE,
            type VARCHAR(50) NOT NULL DEFAULT 'admin',
            level INT NOT NULL DEFAULT 0,
            is_system TINYINT(1) NOT NULL DEFAULT 0,
            created_at DATETIME NULL,
            updated_at DATETIME NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");

        $db->exec("CREATE TABLE IF NOT EXISTS tbl_permissions (
            id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            permission_key VARCHAR(150) NOT NULL UNIQUE,
            name VARCHAR(150) NOT NULL,
            group_name VARCHAR(100) NOT NULL DEFAULT 'General',
            type VARCHAR(50) NOT NULL DEFAULT 'feature',
            created_at DATETIME NULL,
            updated_at DATETIME NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");

        $db->exec("CREATE TABLE IF NOT EXISTS tbl_role_permissions (
            role_id INT UNSIGNED NOT NULL,
            permission_id INT UNSIGNED NOT NULL,
            PRIMARY KEY (role_id, permission_id),
            INDEX idx_role_permissions_permission_id (permission_id)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");

        $db->exec("CREATE TABLE IF NOT EXISTS tbl_user_roles (
            user_id INT UNSIGNED NOT NULL,
            role_id INT UNSIGNED NOT NULL,
            PRIMARY KEY (user_id, role_id),
            INDEX idx_user_roles_role_id (role_id)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");

        $db->exec("CREATE TABLE IF NOT EXISTS tbl_user_hierarchy (
            ancestor_id INT UNSIGNED NOT NULL,
            descendant_id INT UNSIGNED NOT NULL,
            depth INT UNSIGNED NOT NULL DEFAULT 0,
            PRIMARY KEY (ancestor_id, descendant_id),
            INDEX idx_user_hierarchy_descendant_id (descendant_id)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");

        self::addColumnIfMissing('tbl_users', 'parent_id', 'INT UNSIGNED NULL');
        self::addColumnIfMissing('tbl_users', 'reseller_level', 'INT UNSIGNED NULL');
        self::addColumnIfMissing('tbl_customers', 'owner_user_id', 'INT UNSIGNED NULL');
        self::addIndexIfMissing('tbl_users', 'idx_users_parent_id', 'parent_id');
        self::addIndexIfMissing('tbl_users', 'idx_users_reseller_level', 'reseller_level');
        self::addIndexIfMissing('tbl_customers', 'idx_customers_owner_user_id', 'owner_user_id');

        foreach (['tbl_transactions', 'tbl_user_recharges', 'tbl_payment_gateway'] as $table) {
            if (self::tableExists($table)) {
                self::addColumnIfMissing($table, 'owner_user_id', 'INT UNSIGNED NULL');
                self::addIndexIfMissing($table, 'idx_' . $table . '_owner_user_id', 'owner_user_id');
            }
        }

        self::ensureConfig('max_reseller_depth', '3');
    }

    private static function seedLegacyRoles()
    {
        $roles = [
            ['SuperAdmin', 'superadmin', 'system', 100],
            ['Admin', 'admin', 'system', 90],
            ['Agent', 'agent', 'reseller', 50],
            ['Sales', 'sales', 'staff', 40],
            ['Report', 'report', 'staff', 30],
        ];

        foreach ($roles as $role) {
            $existing = ORM::for_table('tbl_roles')->where('slug', $role[1])->find_one();
            if (!$existing) {
                $existing = ORM::for_table('tbl_roles')->create();
                $existing->name = $role[0];
                $existing->slug = $role[1];
                $existing->type = $role[2];
                $existing->level = $role[3];
                $existing->is_system = 1;
                $existing->created_at = date('Y-m-d H:i:s');
                $existing->updated_at = date('Y-m-d H:i:s');
                $existing->save();
            }
        }
    }

    private static function seedPermissions()
    {
        $permissions = [
            'menu.dashboard' => ['Dashboard Menu', 'Menu', 'menu'],
            'menu.customers' => ['Customer Menu', 'Menu', 'menu'],
            'menu.services' => ['Services Menu', 'Menu', 'menu'],
            'menu.internet_plan' => ['Internet Plan Menu', 'Menu', 'menu'],
            'menu.maps' => ['Maps Menu', 'Menu', 'menu'],
            'menu.reports' => ['Reports Menu', 'Menu', 'menu'],
            'menu.message' => ['Send Message Menu', 'Menu', 'menu'],
            'menu.network' => ['Network Menu', 'Menu', 'menu'],
            'menu.radius' => ['Radius Menu', 'Menu', 'menu'],
            'menu.pages' => ['Static Pages Menu', 'Menu', 'menu'],
            'menu.settings' => ['Settings Menu', 'Menu', 'menu'],
            'menu.logs' => ['Logs Menu', 'Menu', 'menu'],
            'menu.documentation' => ['Documentation Menu', 'Menu', 'menu'],
            'menu.community' => ['Community Menu', 'Menu', 'menu'],
            'services.active_customers' => ['Active Customers', 'Services', 'submenu'],
            'services.refill' => ['Refill Customer', 'Services', 'submenu'],
            'services.vouchers' => ['Vouchers', 'Services', 'submenu'],
            'services.coupons' => ['Coupons', 'Services', 'submenu'],
            'services.recharge' => ['Recharge Customer', 'Services', 'submenu'],
            'services.deposit' => ['Refill Balance', 'Services', 'submenu'],
            'plans.hotspot' => ['Hotspot Plans', 'Internet Plan', 'submenu'],
            'plans.pppoe' => ['PPPOE Plans', 'Internet Plan', 'submenu'],
            'plans.vpn' => ['VPN Plans', 'Internet Plan', 'submenu'],
            'plans.bandwidth' => ['Bandwidth', 'Internet Plan', 'submenu'],
            'plans.balance' => ['Customer Balance Plans', 'Internet Plan', 'submenu'],
            'maps.customer' => ['Customer Map', 'Maps', 'submenu'],
            'maps.routers' => ['Router Map', 'Maps', 'submenu'],
            'maps.odp' => ['ODP Map', 'Maps', 'submenu'],
            'reports.daily' => ['Daily Reports', 'Reports', 'submenu'],
            'reports.activation' => ['Activation History', 'Reports', 'submenu'],
            'message.single' => ['Single Customer Message', 'Messages', 'submenu'],
            'message.bulk' => ['Bulk Customer Message', 'Messages', 'submenu'],
            'network.routers' => ['Routers', 'Network', 'submenu'],
            'network.pool' => ['IP Pool', 'Network', 'submenu'],
            'network.port_pool' => ['Port Pool', 'Network', 'submenu'],
            'network.odp' => ['ODP List', 'Network', 'submenu'],
            'radius.nas' => ['Radius NAS', 'Radius', 'submenu'],
            'pages.order_voucher' => ['Order Voucher Page', 'Static Pages', 'submenu'],
            'pages.voucher' => ['Theme Voucher Page', 'Static Pages', 'submenu'],
            'pages.announcement' => ['Announcement Page', 'Static Pages', 'submenu'],
            'pages.customer_announcement' => ['Customer Announcement Page', 'Static Pages', 'submenu'],
            'pages.registration_info' => ['Registration Info Page', 'Static Pages', 'submenu'],
            'pages.payment_info' => ['Payment Info Page', 'Static Pages', 'submenu'],
            'pages.privacy_policy' => ['Privacy Policy Page', 'Static Pages', 'submenu'],
            'pages.terms' => ['Terms and Conditions Page', 'Static Pages', 'submenu'],
            'logs.system' => ['System Logs', 'Logs', 'submenu'],
            'logs.radius' => ['Radius Logs', 'Logs', 'submenu'],
            'logs.message' => ['Message Logs', 'Logs', 'submenu'],
            'settings.general' => ['Manage General Settings', 'Settings', 'feature'],
            'settings.users' => ['Manage Administrator Users', 'Settings', 'feature'],
            'settings.backup' => ['Backup and Restore', 'Settings', 'feature'],
            'settings.payment_gateway' => ['Manage Payment Gateway', 'Settings', 'feature'],
            'settings.plugin_manager' => ['Manage Plugins', 'Settings', 'feature'],
            'customers.view' => ['View Customers', 'Customers', 'feature'],
            'customers.create' => ['Add Customer', 'Customers', 'feature'],
            'customers.edit' => ['Edit Customers', 'Customers', 'feature'],
            'customers.delete' => ['Delete Customers', 'Customers', 'feature'],
            'customers.recharge' => ['Recharge Customers', 'Customers', 'feature'],
            'customers.export' => ['Export Customers', 'Customers', 'feature'],
            'plans.view' => ['View Internet Plan Pages', 'Plans', 'feature'],
            'plans.manage' => ['Add/Edit/Delete Internet Plans', 'Plans', 'feature'],
            'network.manage' => ['Manage Network', 'Network', 'feature'],
            'message.send' => ['Send Messages', 'Messages', 'feature'],
            'reports.view' => ['View Reports', 'Reports', 'feature'],
            'reports.export' => ['Export Reports', 'Reports', 'feature'],
            'resellers.view' => ['View Resellers', 'Resellers', 'feature'],
            'resellers.create' => ['Create Resellers', 'Resellers', 'feature'],
            'resellers.edit' => ['Edit Resellers', 'Resellers', 'feature'],
            'rbac.manage' => ['Manage Roles and Permissions', 'Settings', 'feature'],
            'data.scope.global' => ['View All Owners Data', 'Data Scope', 'feature'],
            'plugins.asset_manager.view' => ['View Asset Manager Plugin', 'Plugins', 'plugin'],
            'plugins.data_usage.view' => ['View User Data Usage Plugin', 'Plugins', 'plugin'],
            'plugins.mikrotik_monitor.view' => ['View MikroTik Monitor Plugin', 'Plugins', 'plugin'],
            'plugins.speedtest.manage' => ['Manage Internet Speedtest Plugin', 'Plugins', 'plugin'],
            'plugins.verimor_sms.manage' => ['Manage Verimor SMS Gateway Plugin', 'Plugins', 'plugin'],
            'plugins.whatsapp_gateway.manage' => ['Manage Whatsapp Gateway Plugin', 'Plugins', 'plugin'],
        ];

        foreach ($permissions as $key => $meta) {
            self::registerPermission($key, $meta[0], $meta[1], $meta[2]);
        }
    }

    private static function mapLegacyUsers()
    {
        $users = ORM::for_table('tbl_users')->select('id')->select('user_type')->find_array();
        foreach ($users as $user) {
            $hasAnyRole = ORM::for_table('tbl_user_roles')
                ->where('user_id', $user['id'])
                ->find_one();
            if ($hasAnyRole) {
                continue;
            }

            $slug = strtolower((string) $user['user_type']);
            if ($slug == 'superadmin') {
                $slug = 'superadmin';
            }
            $role = ORM::for_table('tbl_roles')->where('slug', $slug)->find_one();
            if (!$role) {
                continue;
            }

            $row = ORM::for_table('tbl_user_roles')->create();
            $row->user_id = $user['id'];
            $row->role_id = $role['id'];
            $row->save();
        }
    }

    private static function backfillOwnership()
    {
        $seedVersion = '20260509-owner-backfill-v1';
        $seeded = ORM::for_table('tbl_appconfig')->where('setting', 'rbac_owner_backfill_done')->find_one();
        if ($seeded && $seeded['value'] == $seedVersion) {
            return;
        }

        $db = ORM::get_db();
        if (self::tableExists('tbl_customers') && self::columnExists('tbl_customers', 'owner_user_id') && self::columnExists('tbl_customers', 'created_by')) {
            $db->exec("UPDATE tbl_customers SET owner_user_id = created_by WHERE owner_user_id IS NULL AND created_by IS NOT NULL AND created_by <> 0");
        }

        if (self::tableExists('tbl_user_recharges') && self::columnExists('tbl_user_recharges', 'owner_user_id')) {
            if (self::columnExists('tbl_user_recharges', 'customer_id')) {
                $db->exec("UPDATE tbl_user_recharges ur INNER JOIN tbl_customers c ON ur.customer_id = c.id SET ur.owner_user_id = COALESCE(c.owner_user_id, c.created_by) WHERE ur.owner_user_id IS NULL");
            } else if (self::columnExists('tbl_user_recharges', 'username')) {
                $db->exec("UPDATE tbl_user_recharges ur INNER JOIN tbl_customers c ON ur.username = c.username SET ur.owner_user_id = COALESCE(c.owner_user_id, c.created_by) WHERE ur.owner_user_id IS NULL");
            }
        }

        if (self::tableExists('tbl_transactions') && self::columnExists('tbl_transactions', 'owner_user_id') && self::columnExists('tbl_transactions', 'username')) {
            $db->exec("UPDATE tbl_transactions t INNER JOIN tbl_customers c ON t.username = c.username SET t.owner_user_id = COALESCE(c.owner_user_id, c.created_by) WHERE t.owner_user_id IS NULL");
        }

        if (self::tableExists('tbl_payment_gateway') && self::columnExists('tbl_payment_gateway', 'owner_user_id') && self::columnExists('tbl_payment_gateway', 'username')) {
            $db->exec("UPDATE tbl_payment_gateway pg INNER JOIN tbl_customers c ON pg.username = c.username SET pg.owner_user_id = COALESCE(c.owner_user_id, c.created_by) WHERE pg.owner_user_id IS NULL");
        }

        if (!$seeded) {
            $seeded = ORM::for_table('tbl_appconfig')->create();
            $seeded->setting = 'rbac_owner_backfill_done';
        }
        $seeded->value = $seedVersion;
        $seeded->save();
    }

    private static function backfillUserHierarchy()
    {
        if (!self::tableExists('tbl_users') || !self::tableExists('tbl_user_hierarchy')) {
            return;
        }

        $seedVersion = '20260510-user-hierarchy-v2';
        $seeded = ORM::for_table('tbl_appconfig')->where('setting', 'rbac_user_hierarchy_backfill_done')->find_one();
        if ($seeded && $seeded['value'] == $seedVersion) {
            return;
        }

        if (self::columnExists('tbl_users', 'root') && self::columnExists('tbl_users', 'parent_id')) {
            ORM::get_db()->exec("UPDATE tbl_users SET parent_id = root WHERE (parent_id IS NULL OR parent_id = 0) AND root IS NOT NULL AND root <> 0");
        }

        $users = ORM::for_table('tbl_users')
            ->select('id')
            ->select('parent_id')
            ->order_by_asc('reseller_level')
            ->order_by_asc('id')
            ->find_array();

        foreach ($users as $user) {
            self::syncUserHierarchy($user['id'], $user['parent_id']);
        }

        if (!$seeded) {
            $seeded = ORM::for_table('tbl_appconfig')->create();
            $seeded->setting = 'rbac_user_hierarchy_backfill_done';
        }
        $seeded->value = $seedVersion;
        $seeded->save();
    }

    private static function seedLegacyRolePermissions()
    {
        $seedVersion = '20260510-menu-submenu-permissions';
        $seeded = ORM::for_table('tbl_appconfig')->where('setting', 'rbac_legacy_permissions_seeded')->find_one();
        if ($seeded && $seeded['value'] == $seedVersion) {
            return;
        }

        $rolePermissions = [
            'superadmin' => array_keys(self::$permissions),
            'admin' => [
                'menu.dashboard', 'menu.customers', 'menu.services', 'menu.internet_plan', 'menu.maps',
                'menu.reports', 'menu.message', 'menu.network', 'menu.radius', 'menu.pages', 'menu.settings',
                'menu.logs', 'menu.documentation', 'menu.community',
                'services.active_customers', 'services.refill', 'services.vouchers', 'services.coupons',
                'services.recharge', 'services.deposit',
                'plans.hotspot', 'plans.pppoe', 'plans.vpn', 'plans.bandwidth', 'plans.balance',
                'maps.customer', 'maps.routers', 'maps.odp',
                'reports.daily', 'reports.activation',
                'message.single', 'message.bulk',
                'network.routers', 'network.pool', 'network.port_pool', 'network.odp',
                'radius.nas',
                'pages.order_voucher', 'pages.voucher', 'pages.announcement', 'pages.customer_announcement',
                'pages.registration_info', 'pages.payment_info', 'pages.privacy_policy', 'pages.terms',
                'logs.system', 'logs.radius', 'logs.message',
                'settings.general', 'settings.users', 'settings.backup', 'settings.payment_gateway', 'settings.plugin_manager',
                'customers.view', 'customers.create', 'customers.edit', 'customers.delete',
                'customers.recharge', 'customers.export', 'reports.view', 'reports.export',
                'plans.view', 'plans.manage', 'network.manage', 'message.send',
                'resellers.view', 'resellers.create', 'resellers.edit', 'rbac.manage', 'data.scope.global',
                'plugins.asset_manager.view', 'plugins.data_usage.view', 'plugins.mikrotik_monitor.view',
                'plugins.speedtest.manage', 'plugins.verimor_sms.manage', 'plugins.whatsapp_gateway.manage',
            ],
            'agent' => [
                'menu.dashboard', 'menu.customers', 'menu.services', 'menu.maps', 'menu.message', 'menu.settings',
                'services.active_customers', 'services.refill', 'services.recharge', 'services.deposit',
                'maps.customer', 'message.single', 'message.bulk',
                'settings.users', 'customers.view', 'customers.create', 'customers.recharge', 'message.send',
                'plugins.asset_manager.view',
            ],
            'sales' => [
                'menu.dashboard', 'menu.customers', 'menu.services', 'menu.maps', 'menu.message',
                'services.active_customers', 'services.refill', 'services.recharge', 'services.deposit',
                'maps.customer', 'message.single', 'message.bulk',
                'customers.view', 'customers.create', 'customers.recharge', 'message.send',
            ],
            'report' => [
                'menu.dashboard', 'menu.maps', 'menu.reports', 'maps.customer',
                'reports.daily', 'reports.activation', 'reports.view', 'reports.export',
            ],
        ];

        foreach ($rolePermissions as $roleSlug => $permissionKeys) {
            $role = ORM::for_table('tbl_roles')->where('slug', $roleSlug)->find_one();
            if (!$role) {
                continue;
            }

            foreach ($permissionKeys as $permissionKey) {
                $permission = ORM::for_table('tbl_permissions')->where('permission_key', $permissionKey)->find_one();
                if (!$permission) {
                    continue;
                }

                $exists = ORM::for_table('tbl_role_permissions')
                    ->where('role_id', $role['id'])
                    ->where('permission_id', $permission['id'])
                    ->find_one();
                if ($exists) {
                    continue;
                }

                $row = ORM::for_table('tbl_role_permissions')->create();
                $row->role_id = $role['id'];
                $row->permission_id = $permission['id'];
                $row->save();
            }
        }

        if (!$seeded) {
            $seeded = ORM::for_table('tbl_appconfig')->create();
            $seeded->setting = 'rbac_legacy_permissions_seeded';
        }
        $seeded->value = $seedVersion;
        $seeded->save();
    }

    private static function hasPermission($userId, $permissionKey)
    {
        $permission = ORM::for_table('tbl_permissions')->where('permission_key', $permissionKey)->find_one();
        if (!$permission) {
            return false;
        }

        $roleId = self::getUserRoleId($userId);
        if (!$roleId) {
            return false;
        }

        $count = ORM::for_table('tbl_role_permissions')
            ->where('role_id', $roleId)
            ->where('permission_id', $permission['id'])
            ->count();

        return $count > 0;
    }

    private static function hasImpliedPermission($userId, $permissionKey)
    {
        $impliedBy = [
            'customers.view' => ['menu.customers'],
            'plans.view' => ['menu.internet_plan'],
        ];

        if (empty($impliedBy[$permissionKey])) {
            return false;
        }

        foreach ($impliedBy[$permissionKey] as $parentPermissionKey) {
            if (self::hasPermission($userId, $parentPermissionKey)) {
                return true;
            }
        }

        return false;
    }

    private static function userHasRoles($userId)
    {
        return ORM::for_table('tbl_user_roles')->where('user_id', $userId)->count() > 0;
    }

    private static function legacyCan($admin, $permissionKey)
    {
        $type = $admin['user_type'];
        if ($type == 'SuperAdmin') {
            return true;
        }

        $map = [
            'Admin' => [
                'menu.dashboard', 'menu.customers', 'menu.services', 'menu.internet_plan', 'menu.maps',
                'menu.reports', 'menu.message', 'menu.network', 'menu.radius', 'menu.pages', 'menu.settings',
                'menu.logs', 'menu.documentation', 'menu.community',
                'settings.general', 'settings.users', 'settings.backup', 'settings.payment_gateway', 'settings.plugin_manager',
                'customers.view', 'customers.create', 'customers.edit', 'customers.delete',
                'customers.recharge', 'customers.export', 'reports.view', 'reports.export',
                'plans.view', 'plans.manage', 'network.manage', 'message.send',
                'resellers.view', 'resellers.create', 'resellers.edit', 'rbac.manage',
                'plugins.asset_manager.view', 'plugins.data_usage.view', 'plugins.mikrotik_monitor.view',
                'plugins.speedtest.manage', 'plugins.verimor_sms.manage', 'plugins.whatsapp_gateway.manage',
            ],
            'Agent' => [
                'menu.dashboard', 'menu.customers', 'menu.services', 'menu.maps', 'menu.message', 'menu.settings',
                'settings.users', 'customers.view', 'customers.create', 'customers.recharge', 'message.send',
                'plugins.asset_manager.view',
            ],
            'Sales' => [
                'menu.dashboard', 'menu.customers', 'menu.services', 'menu.maps', 'menu.message',
                'customers.view', 'customers.create', 'customers.recharge', 'message.send',
            ],
            'Report' => [
                'menu.dashboard', 'menu.maps', 'menu.reports', 'reports.view', 'reports.export',
            ],
        ];

        return isset($map[$type]) && in_array($permissionKey, $map[$type]);
    }

    private static function upsertPermission($permissionKey, $meta)
    {
        $permission = ORM::for_table('tbl_permissions')->where('permission_key', $permissionKey)->find_one();
        if (!$permission) {
            $permission = ORM::for_table('tbl_permissions')->create();
            $permission->permission_key = $permissionKey;
            $permission->created_at = date('Y-m-d H:i:s');
        }

        $permission->name = $meta['name'];
        $permission->group_name = $meta['group_name'];
        $permission->type = $meta['type'];
        $permission->updated_at = date('Y-m-d H:i:s');
        $permission->save();
    }

    private static function getDescendantIds($userId)
    {
        $descendants = [];
        $children = ORM::for_table('tbl_users')->select('id')->where('parent_id', $userId)->find_array();
        foreach ($children as $child) {
            $childId = (int) $child['id'];
            $descendants[] = $childId;
            $descendants = array_merge($descendants, self::getDescendantIds($childId));
        }
        return $descendants;
    }

    private static function addColumnIfMissing($table, $column, $definition)
    {
        if (!self::tableExists($table) || self::columnExists($table, $column)) {
            return;
        }
        ORM::get_db()->exec("ALTER TABLE `$table` ADD COLUMN `$column` $definition");
    }

    private static function addIndexIfMissing($table, $index, $column)
    {
        if (!self::tableExists($table) || !self::columnExists($table, $column)) {
            return;
        }

        $statement = ORM::get_db()->prepare("SHOW INDEX FROM `$table` WHERE Key_name = ?");
        $statement->execute([$index]);
        if ($statement->fetchColumn() !== false) {
            return;
        }

        ORM::get_db()->exec("ALTER TABLE `$table` ADD INDEX `$index` (`$column`)");
    }

    private static function ensureConfig($setting, $value)
    {
        $row = ORM::for_table('tbl_appconfig')->where('setting', $setting)->find_one();
        if ($row) {
            return;
        }
        $row = ORM::for_table('tbl_appconfig')->create();
        $row->setting = $setting;
        $row->value = $value;
        $row->save();
    }

    private static function tableExists($table)
    {
        $statement = ORM::get_db()->prepare('SHOW TABLES LIKE ?');
        $statement->execute([$table]);
        return $statement->fetchColumn() !== false;
    }

    private static function columnExists($table, $column)
    {
        $statement = ORM::get_db()->prepare("SHOW COLUMNS FROM `$table` LIKE ?");
        $statement->execute([$column]);
        return $statement->fetchColumn() !== false;
    }
}
