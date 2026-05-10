<?php


class top_widget
{
    public function getWidget()
    {
        global $ui, $current_date, $start_date;
        $admin = Admin::_info();

        $iday = Rbac::scopeOwned(ORM::for_table('tbl_transactions'), 'tbl_transactions', $admin)
            ->where('recharged_on', $current_date)
            ->where_not_equal('method', 'Customer - Balance')
            ->where_not_equal('method', 'Recharge Balance - Administrator')
            ->sum('price');

        if ($iday == '') {
            $iday = '0.00';
        }
        $ui->assign('iday', $iday);

        $imonth = Rbac::scopeOwned(ORM::for_table('tbl_transactions'), 'tbl_transactions', $admin)
            ->where_not_equal('method', 'Customer - Balance')
            ->where_not_equal('method', 'Recharge Balance - Administrator')
            ->where_gte('recharged_on', $start_date)
            ->where_lte('recharged_on', $current_date)->sum('price');
        if ($imonth == '') {
            $imonth = '0.00';
        }
        $ui->assign('imonth', $imonth);

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
        return $ui->fetch('widget/top_widget.tpl');
    }
}
