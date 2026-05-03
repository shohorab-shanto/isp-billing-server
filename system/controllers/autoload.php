<?php

/**
 *  PHP Mikrotik Billing (https://github.com/hotspotbilling/phpnuxbill/)
 *  by https://t.me/ibnux
 **/

/**
 * used for ajax
 **/

function autoload_online_users_plan_device($plan)
{
    if (!$plan) {
        return '';
    }
    if (!empty($plan['device'])) {
        return $plan['device'];
    }
    if (!empty($plan['is_radius'])) {
        return 'Radius';
    }
    if (strtoupper($plan['type']) == 'PPPOE') {
        return 'MikrotikPppoe';
    }
    return 'MikrotikHotspot';
}

function autoload_online_users_read_cache($cacheFile, $ttl)
{
    if (!file_exists($cacheFile) || (time() - filemtime($cacheFile)) > $ttl) {
        return false;
    }

    $data = json_decode(file_get_contents($cacheFile), true);
    if (!is_array($data) || !isset($data['count'])) {
        return false;
    }

    $data['cached'] = true;
    return $data;
}

function autoload_online_users_write_cache($cacheFile, $data)
{
    $dir = dirname($cacheFile);
    if (is_dir($dir) && is_writable($dir)) {
        @file_put_contents($cacheFile, json_encode($data));
    }
}

function autoload_online_users_count_from_rows($rows, $property, $validNames)
{
    $seen = [];
    foreach ($rows as $row) {
        $username = (string) $row->getProperty($property);
        if ($username !== '' && isset($validNames[$username])) {
            $seen[$username] = true;
        }
    }
    return count($seen);
}

function autoload_online_users_count_mikrotik($routerName, $type, $validNames, &$errorCount)
{
    if (empty($routerName) || empty($validNames)) {
        return 0;
    }

    try {
        $router = ORM::for_table('tbl_routers')->where('name', $routerName)->find_one();
        if (!$router || empty($router['ip_address'])) {
            $errorCount++;
            return 0;
        }

        $iport = explode(':', $router['ip_address'], 2);
        $client = new \PEAR2\Net\RouterOS\Client(
            $iport[0],
            $router['username'],
            $router['password'],
            isset($iport[1]) ? $iport[1] : null,
            false,
            1
        );

        if (strtoupper($type) == 'PPPOE') {
            $request = new \PEAR2\Net\RouterOS\Request('/ppp active print');
            $property = 'name';
        } else {
            $request = new \PEAR2\Net\RouterOS\Request('/ip hotspot active print');
            $property = 'user';
        }
        $request->setArgument('.proplist', $property);

        $rows = $client->sendSync($request)->getAllOfType(\PEAR2\Net\RouterOS\Response::TYPE_DATA);
        return autoload_online_users_count_from_rows($rows, $property, $validNames);
    } catch (Throwable $e) {
        $errorCount++;
        return 0;
    }
}

function autoload_online_users_count_radius($validNames, $isRest, &$errorCount)
{
    if (empty($validNames)) {
        return 0;
    }

    try {
        if ($isRest) {
            $rows = ORM::for_table('rad_acct')
                ->select('username')
                ->where_in('username', array_keys($validNames))
                ->where('acctStatusType', 'Start')
                ->find_array();
        } else {
            $rows = ORM::for_table('radacct', 'radius')
                ->select('username')
                ->where_in('username', array_keys($validNames))
                ->where_raw('acctstoptime IS NULL')
                ->find_array();
        }

        $seen = [];
        foreach ($rows as $row) {
            if (!empty($row['username']) && isset($validNames[$row['username']])) {
                $seen[$row['username']] = true;
            }
        }
        return count($seen);
    } catch (Throwable $e) {
        $errorCount++;
        return 0;
    }
}

_admin();
$ui->assign('_title', Lang::T('Network'));
$ui->assign('_system_menu', 'network');

$action = $routes['1'];
$ui->assign('_admin', $admin);

switch ($action) {
    case 'pool':
        $routers = _get('routers');
        if (empty($routers)) {
            $d = ORM::for_table('tbl_pool')->find_many();
        } else {
            $d = ORM::for_table('tbl_pool')->where('routers', $routers)->find_many();
        }
        $ui->assign('routers', $routers);
        $ui->assign('d', $d);
        $ui->display('admin/autoload/pool.tpl');
        break;
    case 'bw_name':
        $bw = ORM::for_table('tbl_bandwidth')->select("name_bw")->find_one($routes['2']);
        echo $bw['name_bw'];
        die();
    case 'balance':
        $balance = ORM::for_table('tbl_customers')->select("balance")->find_one($routes['2'])['balance'];
        if ($routes['3'] == '1') {
            echo Lang::moneyFormat($balance);
        } else {
            echo $balance;
        }
        die();
    case 'server':
        $d = ORM::for_table('tbl_routers')->where('enabled', '1')->find_many();
        $ui->assign('d', $d);

        $ui->display('admin/autoload/server.tpl');
        break;
    case 'pppoe_ip_used':
        if (!empty(_get('ip'))) {
            $cs = ORM::for_table('tbl_customers')
                ->select("username")
                ->where_not_equal('id', _get('id'))
                ->where("pppoe_ip", _get('ip'))
                ->findArray();
            if (count($cs) > 0) {
                $c = array_column($cs, 'username');
                die(Lang::T("IP has been used by") . ' : ' . implode(", ", $c));
            }
        }
        die();
    case 'pppoe_username_used':
        if (!empty(_get('u'))) {
            $cs = ORM::for_table('tbl_customers')
                ->select("username")
                ->where_not_equal('id', _get('id'))
                ->where("pppoe_username", _get('u'))
                ->findArray();
            if (count($cs) > 0) {
                $c = array_column($cs, 'username');
                die(Lang::T("Username has been used by") . ' : ' . implode(", ", $c));
            }
        }
        die();
    case 'plan':
        $server = _post('server');
        $jenis = _post('jenis');
        if (in_array($admin['user_type'], array('SuperAdmin', 'Admin'))) {
            switch ($server) {
                case 'radius':
                    $d = ORM::for_table('tbl_plans')->where('is_radius', 1)->where('type', $jenis)->find_many();
                    break;
                case '':
                    break;
                default:
                    $d = ORM::for_table('tbl_plans')->where('routers', $server)->where('type', $jenis)->find_many();
                    break;
            }
        } else {
            switch ($server) {
                case 'radius':
                    $d = ORM::for_table('tbl_plans')->where('is_radius', 1)->where('type', $jenis)->find_many();
                    break;
                case '':
                    break;
                default:
                    $d = ORM::for_table('tbl_plans')->where('routers', $server)->where('type', $jenis)->find_many();
                    break;
            }
        }
        $ui->assign('d', $d);

        $ui->display('admin/autoload/plan.tpl');
        break;
    case 'customer_is_active':
        if ($config['check_customer_online'] == 'yes') {
            $c = ORM::for_table('tbl_customers')->where('username', $routes['2'])->find_one();
            $p = ORM::for_table('tbl_plans')->find_one($routes['3']);
            $dvc = Package::getDevice($p);
            if ($_app_stage != 'Demo') {
                if (file_exists($dvc)) {
                    require_once $dvc;
                    try {
                        //don't wait more than 5 seconds for response from device, otherwise we get timeout error.
                        ini_set('default_socket_timeout', 5);
                        if ((new $p['device'])->online_customer($c, $p['routers'])) {
                            echo '<span style="color: green;" title="online">&bull;</span>';
                        }else{
                            echo '<span style="color: yellow;" title="offline">&bull;</span>';
                        }
                    } catch (Exception $e) {
                        echo '<span style="color: red;" title="'.$e->getMessage().'">&bull;</span>';
                    }
                }
            }
        }
        break;
    case 'count_online_users':
        global $CACHE_PATH;

        $asJson = _get('format') == 'json';
        header($asJson ? 'Content-Type: application/json' : 'Content-Type: text/plain; charset=utf-8');

        if (function_exists('ini_set')) {
            @ini_set('default_socket_timeout', 1);
        }

        $onlineCount = 0;
        $errorCount = 0;
        $response = [
            'count' => 0,
            'errors' => 0,
            'cached' => false
        ];

        if ($config['check_customer_online'] != 'yes' || $_app_stage == 'Demo') {
            echo $asJson ? json_encode($response) : $response['count'];
            exit;
        }

        $cacheFile = $CACHE_PATH . DIRECTORY_SEPARATOR . 'online_users_count.json';
        $cached = autoload_online_users_read_cache($cacheFile, 30);
        if (_get('refresh') != '1' && $cached !== false) {
            echo $asJson ? json_encode($cached) : $cached['count'];
            exit;
        }

        $mikrotikGroups = [];
        $radiusNames = [];
        $radiusRestNames = [];

        if ($config['check_customer_online'] == 'yes') {
            $activeRecharges = ORM::for_table('tbl_user_recharges')->where('status', 'on')->find_array();
            $customerIds = array_unique(array_filter(array_column($activeRecharges, 'customer_id')));
            $planIds = array_unique(array_filter(array_column($activeRecharges, 'plan_id')));
            $customers = [];
            $plans = [];

            if (!empty($customerIds)) {
                foreach (ORM::for_table('tbl_customers')->where_in('id', $customerIds)->find_array() as $customer) {
                    $customers[$customer['id']] = $customer;
                }
            }

            if (!empty($planIds)) {
                foreach (ORM::for_table('tbl_plans')->where_in('id', $planIds)->find_array() as $plan) {
                    $plans[$plan['id']] = $plan;
                }
            }

            foreach ($activeRecharges as $tur) {
                if (empty($tur['username']) || empty($plans[$tur['plan_id']])) {
                    continue;
                }

                $customer = isset($customers[$tur['customer_id']]) ? $customers[$tur['customer_id']] : [];
                $plan = $plans[$tur['plan_id']];
                $device = strtolower(autoload_online_users_plan_device($plan));
                $type = strtoupper(!empty($tur['type']) ? $tur['type'] : $plan['type']);
                $routerName = !empty($tur['routers']) ? $tur['routers'] : $plan['routers'];
                $names = [$tur['username']];

                if ($type == 'PPPOE' && !empty($customer['pppoe_username'])) {
                    $names[] = $customer['pppoe_username'];
                }

                if (strpos($device, 'radiusrest') !== false) {
                    foreach ($names as $name) {
                        $radiusRestNames[$name] = true;
                    }
                } else if (strpos($device, 'radius') !== false) {
                    foreach ($names as $name) {
                        $radiusNames[$name] = true;
                    }
                } else {
                    $countType = ($type == 'PPPOE' || strpos($device, 'pppoe') !== false) ? 'PPPOE' : 'HOTSPOT';
                    foreach ($names as $name) {
                        $mikrotikGroups[$routerName][$countType][$name] = true;
                    }
                }
            }
        }

        foreach ($mikrotikGroups as $routerName => $types) {
            foreach ($types as $type => $names) {
                $onlineCount += autoload_online_users_count_mikrotik($routerName, $type, $names, $errorCount);
            }
        }

        $onlineCount += autoload_online_users_count_radius($radiusNames, false, $errorCount);
        $onlineCount += autoload_online_users_count_radius($radiusRestNames, true, $errorCount);

        $response = [
            'count' => $onlineCount,
            'errors' => $errorCount,
            'cached' => false
        ];
        autoload_online_users_write_cache($cacheFile, $response);

        echo $asJson ? json_encode($response) : $response['count'];
        exit;
        break;
    case 'plan_is_active':
        $ds = ORM::for_table('tbl_user_recharges')->where('customer_id', $routes['2'])->find_array();
        if ($ds) {
            $ps = [];
            $c = ORM::for_table('tbl_customers')->find_one($routes['2']);
            foreach ($ds as $d) {
                if ($d['status'] == 'on') {
                    if ($config['check_customer_online'] == 'yes') {
                        $p = ORM::for_table('tbl_plans')->find_one($d['plan_id']);
                        $dvc = Package::getDevice($p);
                        $status = "";
                        if ($_app_stage != 'Demo') {
                            if (file_exists($dvc)) {
                                require_once $dvc;
                                try {
                                    //don't wait more than 5 seconds for response from device, otherwise we get timeout error.
                                    ini_set('default_socket_timeout', 5);
                                    if ((new $p['device'])->online_customer($c, $p['routers'])) {
                                        $status = '<span style="color: green;" title="online">&bull;</span>';
                                    }else{
                                        $status = '<span style="color: yellow;" title="offline">&bull;</span>';
                                    }
                                } catch (Exception $e) {
                                    $status = '<span style="color: red;" title="'.$e->getMessage().'">&bull;</span>';
                                }
                            }
                        }
                    }
                    $ps[] = ('<span class="label label-primary m-1" title="Expired ' . Lang::dateAndTimeFormat($d['expiration'], $d['time']) . '">' . $d['namebp'] . ' ' . $status . '</span>');
                } else {
                    $ps[] = ('<span class="label label-danger m-1" title="Expired ' . Lang::dateAndTimeFormat($d['expiration'], $d['time']) . '">' . $d['namebp'] . '</span>');
                }
            }
            echo implode("<br>", $ps);
        } else {
            die('');
        }
        break;
    case 'customer_select2':

        $s = addslashes(_get('s'));
        if (empty($s)) {
            $c = ORM::for_table('tbl_customers')->limit(30)->find_many();
        } else {
            $c = ORM::for_table('tbl_customers')->where_raw("(`username` LIKE '%$s%' OR `fullname` LIKE '%$s%' OR `phonenumber` LIKE '%$s%' OR `email` LIKE '%$s%')")->limit(30)->find_many();
        }
        header('Content-Type: application/json');
        foreach ($c as $cust) {
            $json[] = [
                'id' => $cust['id'],
                'text' => $cust['username'] . ' - ' . $cust['fullname'] . ' - ' . $cust['email']
            ];
        }
        echo json_encode(['results' => $json]);
        die();
    default:
        $ui->display('admin/404.tpl');
}
