{include file="sections/header.tpl"}

<div class="row">
    <div class="col-md-4">
        <div class="panel panel-primary panel-hovered panel-stacked mb30">
            <div class="panel-heading">{Lang::T('Create Role')}</div>
            <div class="panel-body">
                <form class="form-horizontal" method="post" action="{Text::url('settings/rbac-role-post')}">
                    <input type="hidden" name="csrf_token" value="{$csrf_token}">
                    <div class="form-group">
                        <label class="col-md-4 control-label">{Lang::T('Name')}</label>
                        <div class="col-md-8">
                            <input type="text" name="name" class="form-control" placeholder="Reseller Level 1">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 control-label">Slug</label>
                        <div class="col-md-8">
                            <input type="text" name="slug" class="form-control" placeholder="reseller_l1">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 control-label">{Lang::T('Role Category')}</label>
                        <div class="col-md-8">
                            <select name="type" class="form-control">
                                <option value="reseller">Reseller</option>
                                <option value="staff">Staff</option>
                                <option value="system">System</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 control-label">{Lang::T('Role Rank')}</label>
                        <div class="col-md-8">
                            <input type="number" name="level" class="form-control" value="10">
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">{Lang::T('Add')}</button>
                </form>
            </div>
        </div>

        <div class="panel panel-default panel-hovered panel-stacked mb30">
            <div class="panel-heading">{Lang::T('Roles')}</div>
            <div class="list-group" style="margin-bottom: 0;">
                {foreach $roles as $role}
                    <a href="{Text::url('settings/rbac&role_id=', $role['id'])}"
                        class="list-group-item {if $selectedRoleId eq $role['id']}active{/if}">
                        <strong>{$role['name']}</strong>
                        <span class="badge">{$role['level']}</span>
                        <div style="font-size: 11px; opacity: .85;">{$role['slug']} | {$role['type']}</div>
                    </a>
                {/foreach}
            </div>
        </div>
    </div>

    <div class="col-md-8">
        {if $selectedRole}
            <div class="panel panel-primary panel-hovered panel-stacked mb30">
                <div class="panel-heading">
                    {Lang::T('Edit Role')} - {$selectedRole['name']}
                </div>
                <div class="panel-body">
                    <form class="form-horizontal" method="post" action="{Text::url('settings/rbac-role-edit-post')}">
                        <input type="hidden" name="csrf_token" value="{$csrf_token}">
                        <input type="hidden" name="role_id" value="{$selectedRole['id']}">
                        <div class="row">
                            <div class="col-sm-4">
                                <label>{Lang::T('Name')}</label>
                                <input type="text" name="name" class="form-control" value="{$selectedRole['name']}">
                            </div>
                            <div class="col-sm-3">
                                <label>Slug</label>
                                <input type="text" name="slug" class="form-control" value="{$selectedRole['slug']}" {if $selectedRole['is_system']}readonly{/if}>
                            </div>
                            <div class="col-sm-3">
                                <label>{Lang::T('Role Category')}</label>
                                {if $selectedRole['is_system']}
                                    <input type="text" name="type" class="form-control" value="{$selectedRole['type']}" readonly>
                                {else}
                                    <select name="type" class="form-control">
                                        <option value="reseller" {if $selectedRole['type'] == 'reseller'}selected{/if}>Reseller</option>
                                        <option value="staff" {if $selectedRole['type'] == 'staff'}selected{/if}>Staff</option>
                                        <option value="system" {if $selectedRole['type'] == 'system'}selected{/if}>System</option>
                                    </select>
                                {/if}
                            </div>
                            <div class="col-sm-2">
                                <label>{Lang::T('Role Rank')}</label>
                                <input type="number" name="level" class="form-control" value="{$selectedRole['level']}">
                            </div>
                        </div>
                        <br>
                        <button type="submit" class="btn btn-success">{Lang::T('Save')}</button>
                        {if $selectedRole['is_system'] eq 0}
                            <a href="{Text::url('settings/rbac-role-delete/', $selectedRole['id'], '&token=', $csrf_token)}"
                               class="btn btn-danger pull-right"
                               onclick="return confirm('{Lang::T('Delete')} {$selectedRole['name']}?')">
                                {Lang::T('Delete')}
                            </a>
                        {else}
                            <span class="btn btn-default disabled pull-right">{Lang::T('System Role')}</span>
                        {/if}
                    </form>
                </div>
            </div>

            <div class="panel panel-primary panel-hovered panel-stacked mb30">
                <div class="panel-heading">
                    {Lang::T('Permissions')} - {$selectedRole['name']}
                </div>
                <div class="panel-body">
                    {if $selectedRole['slug'] == 'superadmin'}
                        <div class="alert alert-info">
                            {Lang::T('Super Administrator permissions are always allowed')}.
                        </div>
                    {else}
                        <form method="post" action="{Text::url('settings/rbac-save')}">
                            <input type="hidden" name="csrf_token" value="{$csrf_token}">
                            <input type="hidden" name="role_id" value="{$selectedRole['id']}">
                            {assign var=roleId value=$selectedRole['id']}
                            {foreach $permissionGroups as $groupName => $groupPermissions}
                                <div class="panel panel-default" style="margin-bottom: 12px;">
                                    <div class="panel-heading">
                                        <strong>{Lang::T($groupName)}</strong>
                                        <small class="text-muted"> - menu, submenu, page, button, and action access</small>
                                        <button type="button" class="btn btn-xs btn-default pull-right js-toggle-section">{Lang::T('Select All')}</button>
                                    </div>
                                    <div class="panel-body">
                                        <div class="row">
                                            {foreach $groupPermissions as $permission}
                                                <div class="col-sm-6" style="min-height: 42px;">
                                                    <label class="checkbox-inline" style="margin-bottom: 4px;">
                                                        <input type="checkbox" name="permissions[]" value="{$permission['id']}"
                                                            {if isset($assigned[$roleId]) && in_array($permission['id'], $assigned[$roleId])}checked{/if}>
                                                        <strong>{$permission['name']}</strong>
                                                        <span class="label label-default">{$permission['type']}</span>
                                                    </label>
                                                    <div class="text-muted" style="padding-left: 22px; font-size: 11px;">{$permission['permission_key']}</div>
                                                </div>
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                            {/foreach}
                            <hr>
                            <button type="submit" class="btn btn-success">{Lang::T('Save Changes')}</button>
                        </form>
                    {/if}
                </div>
            </div>
        {/if}
    </div>
</div>

{literal}
<script>
    $(function () {
        $('.js-toggle-section').on('click', function () {
            var $panel = $(this).closest('.panel');
            var $boxes = $panel.find('input[type="checkbox"]');
            var checked = $boxes.length !== $boxes.filter(':checked').length;
            $boxes.prop('checked', checked);
            $(this).text(checked ? 'Clear All' : 'Select All');
        });
    });
</script>
{/literal}

{include file="sections/footer.tpl"}
