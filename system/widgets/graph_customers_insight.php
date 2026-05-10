<?php

class graph_customers_insight
{
    public function getWidget()
    {
        global $CACHE_PATH,$ui;
        $admin = Admin::_info();
        $u_act = Rbac::scopeOwned(ORM::for_table('tbl_user_recharges'), 'tbl_user_recharges', $admin)->where('status', 'on')->count();
        if (empty($u_act)) {
            $u_act = '0';
        }
        $ui->assign('u_act', $u_act);

        $u_all = Rbac::scopeOwned(ORM::for_table('tbl_user_recharges'), 'tbl_user_recharges', $admin)->count();
        if (empty($u_all)) {
            $u_all = '0';
        }
        $ui->assign('u_all', $u_all);


        $c_all = Rbac::scopeCustomers(ORM::for_table('tbl_customers'), $admin)->count();
        if (empty($c_all)) {
            $c_all = '0';
        }
        $ui->assign('c_all', $c_all);
        return $ui->fetch('widget/graph_customers_insight.tpl');
    }
}
