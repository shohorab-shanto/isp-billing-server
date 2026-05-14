{include file="sections/header.tpl"}
<!-- users -->

<div class="row">
    <div class="col-sm-12">
        <div class="panel panel-hovered mb20 panel-primary">
            <div class="panel-heading">{Lang::T('Manage Administrator')}</div>
            <div class="panel-body">
                <div class="md-whiteframe-z1 mb20" style="padding: 15px">
                    <div class="row">
                    <div class="col-sm-12 col-lg-10">
                        <form id="site-search" method="post" action="{Text::url('settings/users/')}">
                            <input type="hidden" name="csrf_token" value="{$csrf_token}">
                            <div class="row" style="margin-bottom: -10px;">
                                <div class="col-xs-12 col-sm-6 col-md-4" style="margin-bottom: 10px;">
                                    <div class="input-group">
                                        <div class="input-group-addon">
                                            <span class="fa fa-search"></span>
                                        </div>
                                        <input type="text" name="search" value="{$search}" class="form-control"
                                            placeholder="Search username, name, phone, email">
                                    </div>
                                </div>
                                <div class="col-xs-12 col-sm-6 col-md-2" style="margin-bottom: 10px;">
                                    <select name="role_id" class="form-control">
                                        <option value="">{Lang::T('All Roles')}</option>
                                        <option value="none" {if $filterRoleId eq 'none'}selected{/if}>{Lang::T('Default')}</option>
                                        {foreach $roleFilterRoles as $role}
                                            <option value="{$role['id']}" {if $filterRoleId eq $role['id']}selected{/if}>
                                                {$role['name']} ({$role['slug']})
                                            </option>
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="col-xs-12 col-sm-6 col-md-2" style="margin-bottom: 10px;">
                                    <select name="status" class="form-control">
                                        <option value="">{Lang::T('All Status')}</option>
                                        <option value="Active" {if $filterStatus eq 'Active'}selected{/if}>{Lang::T('Active')}</option>
                                        <option value="Inactive" {if $filterStatus eq 'Inactive'}selected{/if}>{Lang::T('Inactive')}</option>
                                    </select>
                                </div>
                                <div class="col-xs-12 col-sm-6 col-md-2" style="margin-bottom: 10px;">
                                    <select name="parent_id" class="form-control">
                                        <option value="">{Lang::T('All Parents')}</option>
                                        <option value="none" {if $filterParentId eq 'none'}selected{/if}>{Lang::T('No Parent')}</option>
                                        {foreach $parentFilterUsers as $parentUser}
                                            <option value="{$parentUser['id']}" {if $filterParentId eq $parentUser['id']}selected{/if}>
                                                {$parentUser['username']} | {$parentUser['user_type']}
                                            </option>
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="col-xs-12 col-sm-6 col-md-2" style="margin-bottom: 10px;">
                                    <button class="btn btn-success btn-block" type="submit">{Lang::T('Filter')}</button>
                                </div>
                                <div class="col-xs-12 col-sm-6 visible-sm visible-xs" style="margin-bottom: 10px;">
                                    <a href="{Text::url('settings/users')}" class="btn btn-default btn-block">{Lang::T('Clear')}</a>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-sm-12 col-lg-2">
                        <a href="{Text::url('settings/users')}" class="btn btn-default btn-block hidden-sm hidden-xs" style="margin-bottom: 10px;">{Lang::T('Clear')}</a>
                        <a href="{Text::url('settings/users-add')}" class="btn btn-primary btn-block">
                            <i class="ion ion-android-add"></i>
                            <span class="hidden-lg">{Lang::T('Add New')}</span>
                            <span class="visible-lg-inline">{Lang::T('Add Admin')}</span>
                        </a>
                    </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-striped table-condensed">
                        <thead>
                            <tr>
                                <th>{Lang::T('User')}</th>
                                <th>{Lang::T('Contact')}</th>
                                <th>{Lang::T('Type')}</th>
                                <th>{Lang::T('Customers')}</th>
                                <th>{Lang::T('Sub Resellers')}</th>
                                <th>{Lang::T('Activity')}</th>
                                <th>{Lang::T('Manage')}</th>
                                <th>ID</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $d as $ds}
                                <tr {if $ds['status'] != 'Active'}class="danger"{/if}>
                                    <td>
                                        <strong>{$ds['username']}</strong>
                                        {if $ds['fullname']}
                                            <div class="text-muted" style="font-size: 12px; line-height: 1.35;">{$ds['fullname']}</div>
                                        {/if}
                                    </td>
                                    <td>
                                        {if $ds['phone']}
                                            <div>{$ds['phone']}</div>
                                        {/if}
                                        {if $ds['email']}
                                            <div class="text-muted" style="font-size: 12px; line-height: 1.35;">{$ds['email']}</div>
                                        {/if}
                                    </td>
                                    <td>
                                        <strong>{$ds['user_type']}</strong>
                                        <div class="text-muted" style="font-size: 12px; line-height: 1.35;">
                                            {if isset($userRoles[$ds['id']]) && count($userRoles[$ds['id']]) gt 0}
                                                {foreach $userRoles[$ds['id']] as $role name=roleLoop}
                                                    {$role['role_name']} <span class="label label-default">{$role['role_type']}</span>{if !$smarty.foreach.roleLoop.last}<br>{/if}
                                                {/foreach}
                                            {else}
                                                {Lang::T('Default')}
                                            {/if}
                                        </div>
                                    </td>
                                    <td>
                                        {assign var=summary value=$resellerSummaries[$ds['id']]}
                                        <strong>{$summary['direct_customers']}</strong>
                                        {if $summary['total_customers'] neq $summary['direct_customers']}
                                            <span class="text-muted">/ {$summary['total_customers']} total</span>
                                        {/if}
                                    </td>
                                    <td>
                                        <strong>{$summary['children_count']}</strong>
                                        {if $summary['children_count'] gt 0}
                                            <div class="text-muted" style="max-width: 220px; white-space: normal;">
                                                {foreach $summary['children'] as $child name=childLoop}
                                                    <a href="{Text::url('settings/users-view/', $child['id'])}">{$child['username']}</a>{if !$smarty.foreach.childLoop.last}, {/if}
                                                {/foreach}
                                            </div>
                                        {/if}
                                    </td>
                                    <td>
                                        <div>
                                            {if $ds['city'] || $ds['subdistrict'] || $ds['ward']}
                                                {$ds['city']}, {$ds['subdistrict']}, {$ds['ward']}
                                            {else}
                                                <span class="text-muted">-</span>
                                            {/if}
                                        </div>
                                        <div class="text-muted" style="font-size: 12px; line-height: 1.35;">
                                            {Lang::T('Last Login')}: {if $ds['last_login']}{Lang::timeElapsed($ds['last_login'])}{else}-{/if}
                                        </div>
                                    </td>
                                    <td>
                                        <a href="{Text::url('settings/users-view/',$ds['id'])}"
                                            class="btn btn-success btn-xs">{Lang::T('View')}</a>
                                        <a href="{Text::url('settings/users-edit/',$ds['id'])}"
                                            class="btn btn-info btn-xs">{Lang::T('Edit')}</a>
                                        {if ($_admin['id']) neq ($ds['id'])}
                                            <a href="{Text::url('settings/users-delete/',$ds['id'])}" id="{$ds['id']}"
                                                class="btn btn-danger btn-xs" onclick="return ask(this, '{Lang::T('Delete')}?')"><i class="glyphicon glyphicon-trash"></i></a>
                                        {/if}
                                    </td>
                                    <td>{$ds['id']}</td>
                                </tr>
                            {/foreach}
                            {if count($d) == 0}
                                <tr>
                                    <td colspan="8" class="text-center text-muted">{Lang::T('No data found')}</td>
                                </tr>
                            {/if}
                        </tbody>
                    </table>
                </div>
                {include file="pagination.tpl"}
            </div>
        </div>
    </div>
</div>

{include file="sections/footer.tpl"}
