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
                            <input type="text" name="name" class="form-control js-role-name" placeholder="Reseller Level 1">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 control-label">Slug</label>
                        <div class="col-md-8">
                            <input type="text" name="slug" class="form-control js-role-slug" placeholder="reseller_level_1">
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
                                <input type="text" name="name" class="form-control js-role-name" value="{$selectedRole['name']}">
                            </div>
                            <div class="col-sm-3">
                                <label>Slug</label>
                                <input type="text" name="slug" class="form-control js-role-slug" value="{$selectedRole['slug']}" {if $selectedRole['is_system']}readonly{/if}>
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
                            <div class="text-right" style="margin-bottom: 12px;">
                                <button type="button" class="btn btn-sm btn-default js-permission-all" data-checked="1">{Lang::T('Select All')}</button>
                                <button type="button" class="btn btn-sm btn-default js-permission-all" data-checked="0">{Lang::T('Clear All')}</button>
                            </div>
                            {foreach $permissionGroups as $groupName => $groupPermissions}
                                <div class="panel panel-default" style="margin-bottom: 12px;">
                                    <div class="panel-heading">
                                        <strong>{Lang::T($groupName)}</strong>
                                        <small class="text-muted"> - menu, submenu, page, button, and action access</small>
                                        <button type="button" class="btn btn-xs btn-default pull-right js-toggle-section"
                                            data-select-label="{Lang::T('Select All')}"
                                            data-clear-label="{Lang::T('Clear All')}">{Lang::T('Select All')}</button>
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
    window.addEventListener('load', function () {
        var $ = window.jQuery;
        if (!$) return;

        var slugify = function (v) {
            return (v || '').toLowerCase().trim().replace(/[^a-z0-9]+/g, '_').replace(/^_+|_+$/g, '').replace(/_+/g, '_');
        };
        var updateSection = function ($btn) {
            var $boxes = $btn.closest('.panel').find('input[name="permissions[]"]');
            $btn.text($boxes.length && $boxes.length === $boxes.filter(':checked').length ? $btn.data('clear-label') : $btn.data('select-label'));
        };
        var updateSections = function () {
            $('.js-toggle-section').each(function () { updateSection($(this)); });
        };

        $('.js-role-slug').data('manual', false);
        $(document).on('input', '.js-role-name', function () {
            var $slug = $(this).closest('form').find('.js-role-slug:not([readonly])');
            if ($slug.length && !$slug.data('manual')) $slug.val(slugify($(this).val()));
        }).on('input', '.js-role-slug:not([readonly])', function () {
            $(this).val(slugify($(this).val())).data('manual', true);
        }).on('click', '.js-permission-all', function () {
            $('input[name="permissions[]"]').prop('checked', $(this).data('checked') == 1);
            updateSections();
        }).on('click', '.js-toggle-section', function () {
            var $boxes = $(this).closest('.panel').find('input[name="permissions[]"]');
            $boxes.prop('checked', $boxes.length !== $boxes.filter(':checked').length);
            updateSection($(this));
        }).on('change', 'input[name="permissions[]"]', updateSections);

        updateSections();
    });
</script>
{/literal}

{include file="sections/footer.tpl"}
