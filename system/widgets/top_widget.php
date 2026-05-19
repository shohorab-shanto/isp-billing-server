<?php


class top_widget
{
    public function getWidget()
    {
        global $ui, $current_date, $start_date;
        $admin = Admin::_info();
        $showIncomeWidget = in_array($admin['user_type'], ['SuperAdmin', 'Admin', 'Report']) || Rbac::isResellerUser($admin);
        $ui->assign('showIncomeWidget', $showIncomeWidget);
        $incomeOwnerIds = [(int) $admin['id']];
        if ($admin['user_type'] == 'SuperAdmin') {
            $incomeOwnerRows = ORM::for_table('tbl_users')
                ->select('id')
                ->where_in('user_type', ['SuperAdmin', 'Admin'])
                ->find_array();
            $incomeOwnerIds = array_map('intval', array_column($incomeOwnerRows, 'id'));
            if (empty($incomeOwnerIds)) {
                $incomeOwnerIds = [(int) $admin['id']];
            }
        }

        $iday = ORM::for_table('tbl_transactions');
        if ($admin['user_type'] == 'SuperAdmin') {
            $iday->where_raw('(owner_user_id IN (' . implode(',', array_fill(0, count($incomeOwnerIds), '?')) . ') OR owner_user_id IS NULL)', $incomeOwnerIds);
        } else {
            $iday->where_in('owner_user_id', $incomeOwnerIds);
        }
        $iday = $iday->where('recharged_on', $current_date)
            ->where_not_equal('method', 'Customer - Balance')
            ->where_not_equal('method', 'Recharge Balance - Administrator')
            ->sum('price');

        if ($iday == '') {
            $iday = '0.00';
        }
        $ui->assign('iday', $iday);

        $imonth = ORM::for_table('tbl_transactions');
        if ($admin['user_type'] == 'SuperAdmin') {
            $imonth->where_raw('(owner_user_id IN (' . implode(',', array_fill(0, count($incomeOwnerIds), '?')) . ') OR owner_user_id IS NULL)', $incomeOwnerIds);
        } else {
            $imonth->where_in('owner_user_id', $incomeOwnerIds);
        }
        $imonth = $imonth->where_not_equal('method', 'Customer - Balance')
            ->where_not_equal('method', 'Recharge Balance - Administrator')
            ->where_gte('recharged_on', $start_date)
            ->where_lte('recharged_on', $current_date)->sum('price');
        if ($imonth == '') {
            $imonth = '0.00';
        }
        $ui->assign('imonth', $imonth);

        $itotal = ORM::for_table('tbl_transactions');
        if ($admin['user_type'] == 'SuperAdmin') {
            $itotal->where_raw('(owner_user_id IN (' . implode(',', array_fill(0, count($incomeOwnerIds), '?')) . ') OR owner_user_id IS NULL)', $incomeOwnerIds);
        } else {
            $itotal->where_in('owner_user_id', $incomeOwnerIds);
        }
        $itotal = $itotal->where_not_equal('method', 'Customer - Balance')
            ->where_not_equal('method', 'Recharge Balance - Administrator')
            ->sum('price');
        if ($itotal == '') {
            $itotal = '0.00';
        }
        $ui->assign('itotal', $itotal);

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

        $c_disabled = Rbac::scopeCustomers(ORM::for_table('tbl_customers'), $admin)->where('status', 'Disabled')->count();
        if (empty($c_disabled)) {
            $c_disabled = '0';
        }
        $ui->assign('c_disabled', $c_disabled);

        return $ui->fetch('widget/top_widget.tpl');
    }
}
