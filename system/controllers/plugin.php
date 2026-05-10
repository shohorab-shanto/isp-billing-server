<?php
/**
 *  PHP Mikrotik Billing (https://github.com/hotspotbilling/phpnuxbill/)
 *  by https://t.me/ibnux
 **/

$function = $routes[1];
$registeredRoute = $plugin_routes_registered[$function] ?? null;

if ($registeredRoute) {
    if ($registeredRoute['admin']) {
        _admin();
        if (!empty($registeredRoute['permission']) && !can($registeredRoute['permission'], $admin)) {
            r2(getUrl('dashboard'), 'e', Lang::T('You do not have permission to access this page'));
        }
    } else if ($registeredRoute['customer']) {
        _auth();
    }

    if (function_exists($registeredRoute['function'])) {
        call_user_func($registeredRoute['function']);
    } else {
        r2(getUrl('dashboard'), 'e', 'Function not found');
    }
} else if (function_exists($function)) {
    // Backward-compatible fallback for old plugins. New plugins should register
    // explicit routes and permissions with register_plugin_route().
    if (_admin(false)) {
        $fallbackAdmin = Admin::_info();
        if (!in_array($fallbackAdmin['user_type'], ['SuperAdmin', 'Admin'])) {
            r2(getUrl('dashboard'), 'e', Lang::T('You do not have permission to access this page'));
        }
    }
    call_user_func($function);
} else {
    r2(getUrl('dashboard'), 'e', 'Function not found');
}
