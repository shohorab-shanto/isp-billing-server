<?php
register_menu(
    "User Data Usage",
    true,
    "UserDataUsageAdmin",
    'SERVICES',
    '',
    '',
    'success',
    [],
    'plugins.data_usage.view'
);
register_plugin_route("UserDataUsageAdmin", 'plugins.data_usage.view', true, false);

function UserDataUsageAdmin()
{
    global $ui;
    _admin();
    if (!can('plugins.data_usage.view')) {
        r2(U . "dashboard", 'e', Lang::T('You do not have permission to access this page'));
        return;
    }
    $ui->assign('_title', 'User Data Usage');
    $ui->assign('_system_menu', '');
    $admin = Admin::_info();
    $ui->assign('_admin', $admin);
    $search = $_POST['q'] ?? '';
    $page = !isset($_GET['page']) ? 1 : (int)$_GET['page'];
    $perPage = 10;

    $total = UserDataUsageAdmin_count_user_in_out_data_admin($search);

    if (is_string($total)) {
        r2(U . "dashboard", 'e', $total);
        return;
    }

    $data = UserDataUsageAdmin_fetch_user_in_out_data_admin($search, $page, $perPage);
    $pagination = UserDataUsageAdmin_create_pagination_admin($page, $perPage, $total);

    $ui->assign('q', $search);
    $ui->assign('data', $data);
    $ui->assign('pagination', $pagination);
    $ui->display('data_usage_admin.tpl');
}


function UserDataUsageAdmin_fetch_user_in_out_data_admin($search = '', $page = 1, $perPage = 10)
{
    $source = UserDataUsageAdmin_get_accounting_source_admin();
    if ($source === null) {
        return [];
    }

    $table = $source['table'];
    $connection = $source['connection'];
    $query = ORM::for_table($table, $connection)->where_not_equal('acctoutputoctets', 0);

    // Handle search functionality
    if ($search) {
        $query->where_like('username', '%' . $search . '%');
    }

    // Apply pagination limits
    $query->limit($perPage)->offset(($page - 1) * $perPage);
    $data = Paginator::findMany($query, [], $perPage);

    // Processing each record
    foreach ($data as &$row) {
        // Converting octet values into readable formats
        $row->acctOutputOctets = UserDataUsageAdmin_convert_bytes_admin(floatval($row->acctoutputoctets));
        $row->acctInputOctets = UserDataUsageAdmin_convert_bytes_admin(floatval($row->acctinputoctets));
        $row->totalBytes = UserDataUsageAdmin_convert_bytes_admin(floatval($row->acctoutputoctets) + floatval($row->acctinputoctets));

        // Fetch the last record for status determination
        $lastRecord = ORM::for_table($table, $connection)
            ->where('username', $row->username)
            ->where_not_equal('acctoutputoctets', 0)
            ->order_by_desc($source['status_column'])
            ->find_one();

        // Set connection status based on the last record's type
        $isConnected = $source['status_column'] === 'acctstatustype'
            ? ($lastRecord && ($lastRecord->acctstatustype === 'Start' || $lastRecord->acctstatustype === 'Interim-Update'))
            : ($lastRecord && $lastRecord->acctstoptime === null);

        if ($isConnected) {
            $row->status = '<span class="badge btn-success">Connected</span>';
        } else {
            $row->status = '<span class="badge btn-danger">Disconnected</span>';
        }

        // Set the start date
        $row->sdate = $lastRecord ? ($lastRecord[$source['date_column']] ?? '') : '';
    }

    return $data;
}




function UserDataUsageAdmin_count_user_in_out_data_admin($search = '')
{
    $source = UserDataUsageAdmin_get_accounting_source_admin();

    // If no table exists, return an error message
    if ($source === null) {
        return "Error: No valid accounting table found. Enable Radius accounting or install the rad_acct/radacct table.";
    }

    $query = ORM::for_table($source['table'], $source['connection'])->where_not_equal('acctoutputoctets', 0.00);

    // Apply search filter if applicable
    if ($search) {
        $query->where_like('username', '%' . $search . '%');
    }

    // Return the total count of records
    $count = $query->count();
    if ($count === false) {
        return "Error: Unable to retrieve the count of records.";
    }
    return $count;
}

function UserDataUsageAdmin_get_accounting_source_admin()
{
    $sources = [
        [
            'table' => 'rad_acct',
            'connection' => ORM::DEFAULT_CONNECTION,
            'status_column' => 'acctstatustype',
            'date_column' => 'dateAdded',
        ],
        [
            'table' => 'radacct',
            'connection' => ORM::DEFAULT_CONNECTION,
            'status_column' => 'acctstoptime',
            'date_column' => 'acctstarttime',
        ],
        [
            'table' => 'radacct',
            'connection' => 'radius',
            'status_column' => 'acctstoptime',
            'date_column' => 'acctstarttime',
        ],
    ];

    foreach ($sources as $source) {
        if (UserDataUsageAdmin_table_exists_admin($source['table'], $source['connection'])) {
            return $source;
        }
    }

    return null;
}

function UserDataUsageAdmin_table_exists_admin($table, $connection)
{
    try {
        $db = ORM::get_db($connection);
        $statement = $db->prepare('SHOW TABLES LIKE ?');
        $statement->execute([$table]);
        return $statement->fetchColumn() !== false;
    } catch (Exception $e) {
        return false;
    }
}


function UserDataUsageAdmin_create_pagination_admin($page, $perPage, $total)
{
    $pages = ceil($total / $perPage);
    return [
        'current' => $page,
        'total' => $pages,
        'previous' => ($page > 1) ? $page - 1 : null,
        'next' => ($page < $pages) ? $page + 1 : null,
    ];
}

function UserDataUsageAdmin_convert_bytes_admin($bytes)
{
    if ($bytes >= 1073741824) {
        $bytes = number_format($bytes / 1073741824, 2) . ' GB';
    } elseif ($bytes >= 1048576) {
        $bytes = number_format($bytes / 1048576, 2) . ' MB';
    } elseif ($bytes >= 1024) {
        $bytes = number_format($bytes / 1024, 2) . ' KB';
    } elseif ($bytes > 1) {
        $bytes = $bytes . ' bytes';
    } elseif ($bytes == 1) {
        $bytes = $bytes . ' byte';
    } else {
        $bytes = '0 bytes';
    }

    return $bytes;
}
