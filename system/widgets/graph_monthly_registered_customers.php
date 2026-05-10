<?php

class graph_monthly_registered_customers
{
    public function getWidget()
    {
        global $CACHE_PATH,$ui;
        $admin = Admin::_info();
        $cacheSuffix = (!empty($admin) && !Rbac::hasGlobalDataScope($admin)) ? ('_' . (int) $admin['id']) : '';

        $cacheMRfile = $CACHE_PATH . File::pathFixer('/monthlyRegistered' . $cacheSuffix . '.temp');
        //Compatibility for old path
        if (file_exists($oldCacheMRfile = str_replace($CACHE_PATH, '', $cacheMRfile))) {
            rename($oldCacheMRfile, $cacheMRfile);
        }
        //Cache for 1 hour
        if (file_exists($cacheMRfile) && time() - filemtime($cacheMRfile) < 3600) {
            $monthlyRegistered = json_decode(file_get_contents($cacheMRfile), true);
        } else {
            //Monthly Registered Customers
            $result = Rbac::scopeCustomers(ORM::for_table('tbl_customers'), $admin)
                ->select_expr('MONTH(created_at)', 'month')
                ->select_expr('COUNT(*)', 'count')
                ->where_raw('YEAR(created_at) = YEAR(NOW())')
                ->group_by_expr('MONTH(created_at)')
                ->find_many();

            $monthlyRegistered = [];
            foreach ($result as $row) {
                $monthlyRegistered[] = [
                    'date' => $row->month,
                    'count' => $row->count
                ];
            }
            file_put_contents($cacheMRfile, json_encode($monthlyRegistered));
        }
        $ui->assign('monthlyRegistered', $monthlyRegistered);
        return $ui->fetch('widget/graph_monthly_registered_customers.tpl');
    }
}
