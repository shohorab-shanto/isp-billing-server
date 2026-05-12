{include file="sections/header.tpl"}
<!-- user-edit -->

<form class="form-horizontal" method="post" enctype="multipart/form-data" role="form"
    action="{Text::url('settings/users-edit-post')}">
    <input type="hidden" name="csrf_token" value="{$csrf_token}">
    <div class="row">
        <div class="col-sm-6 col-md-6">
            <div
                class="panel panel-{if $d['status'] != 'Active'}danger{else}primary{/if} panel-hovered panel-stacked mb30">
                <div class="panel-heading">{Lang::T('Profile')}</div>
                <div class="panel-body">
                    <input type="hidden" name="id" value="{$d['id']}">
                    <center>
                        <img src="{$app_url}/{$UPLOAD_PATH}{$d['photo']}.thumb.jpg" width="200"
                            onerror="this.src='{$app_url}/{$UPLOAD_PATH}/admin.default.png'" class="img-circle img-responsive" alt="Foto"
                            onclick="return deletePhoto({$d['id']})">
                    </center><br>
                    <div class="form-group">
                        <label class="col-md-3 col-xs-12 control-label">{Lang::T('Photo')}</label>
                        <div class="col-md-6 col-xs-8">
                            <input type="file" class="form-control" name="photo" accept="image/*">
                        </div>
                        <div class="form-group col-md-3 col-xs-4" title="Not always Working">
                            <label class=""><input type="checkbox" checked name="faceDetect" value="yes"> Facedetect</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Full Name')}</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" id="fullname" name="fullname"
                                value="{$d['fullname']}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Phone')}</label>
                        <div class="col-md-9">
                            <input type="number" class="form-control" id="phone" name="phone" value="{$d['phone']}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Email')}</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" id="email" name="email" value="{$d['email']}">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-4">
                            <input type="text" class="form-control" id="city" name="city"
                                placeholder="{Lang::T('City')}" value="{$d['city']}">
                        </div>
                        <div class="col-md-4">
                            <input type="text" class="form-control" id="subdistrict" name="subdistrict"
                                placeholder="{Lang::T('Sub District')}" value="{$d['subdistrict']}">
                        </div>
                        <div class="col-md-4">
                            <input type="text" class="form-control" id="ward" name="ward"
                                placeholder="{Lang::T('Ward')}" value="{$d['ward']}">
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-info panel-hovered panel-stacked mb30">
                <div class="panel-heading">{Lang::T('Reseller Summary')}</div>
                <div class="panel-body">
                    <div class="row text-center">
                        <div class="col-xs-4">
                            <h4 style="margin-top: 0;">{$resellerSummary['direct_customers']}</h4>
                            <span class="text-muted">{Lang::T('Direct Customers')}</span>
                        </div>
                        <div class="col-xs-4">
                            <h4 style="margin-top: 0;">{$resellerSummary['total_customers']}</h4>
                            <span class="text-muted">{Lang::T('Total Customers')}</span>
                        </div>
                        <div class="col-xs-4">
                            <h4 style="margin-top: 0;">{$resellerSummary['children_count']}</h4>
                            <span class="text-muted">{Lang::T('Sub Resellers')}</span>
                        </div>
                    </div>
                    {if $resellerSummary['children_count'] gt 0}
                        <hr>
                        <div class="table-responsive">
                            <table class="table table-condensed" style="margin-bottom: 0;">
                                <thead>
                                    <tr>
                                        <th>{Lang::T('Username')}</th>
                                        <th>{Lang::T('Full Name')}</th>
                                        <th>{Lang::T('Type')}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach $resellerSummary['children'] as $child}
                                        <tr>
                                            <td><a href="{Text::url('settings/users-view/', $child['id'])}">{$child['username']}</a></td>
                                            <td>{$child['fullname']}</td>
                                            <td>{$child['user_type']}</td>
                                        </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </div>
                    {/if}
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-md-6">
            <div
                class="panel panel-{if $d['status'] != 'Active'}danger{else}primary{/if} panel-hovered panel-stacked mb30">
                <div class="panel-heading">{Lang::T('Credentials')}</div>
                <div class="panel-body">
                    {if ($_admin['id']) neq ($d['id'])}
                        <div class="form-group">
                            <label class="col-md-3 control-label">{Lang::T('Status')}</label>
                            <div class="col-md-9">
                                <select name="status" id="status" class="form-control">
                                    <option value="Active" {if $d['status'] eq 'Active'}selected="selected" {/if}>
                                        {Lang::T('Active')}</option>
                                    <option value="Inactive" {if $d['status'] eq 'Inactive'}selected="selected" {/if}>
                                        {Lang::T('Inactive')}</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">{Lang::T('User Type')}</label>
                            <div class="col-md-9">
                                <select name="user_type" id="user_type" class="form-control" onchange="checkUserType(this)">
                                    {if $_admin['user_type'] eq 'Agent' && can('resellers.create', $_admin)}
                                        <option value="Agent" {if $d['user_type'] eq 'Agent'}selected="selected" {/if}>Agent
                                        </option>
                                    {/if}
                                    {if $_admin['user_type'] eq 'Agent'}
                                        <option value="Sales" {if $d['user_type'] eq 'Sales'}selected="selected" {/if}>Sales
                                        </option>
                                    {/if}
                                    {if $_admin['user_type'] eq 'Admin' || $_admin['user_type'] eq 'SuperAdmin'}
                                        <option value="Report" {if $d['user_type'] eq 'Report'}selected="selected" {/if}>Report
                                            Viewer</option>
                                        <option value="Agent" {if $d['user_type'] eq 'Agent'}selected="selected" {/if}>Agent
                                        </option>
                                        <option value="Sales" {if $d['user_type'] eq 'Sales'}selected="selected" {/if}>Sales
                                        </option>
                                    {/if}
                                    {if $_admin['user_type'] eq 'SuperAdmin'}
                                        <option value="Admin" {if $d['user_type'] eq 'Admin'}selected="selected" {/if}>
                                            Administrator</option>
                                        <option value="SuperAdmin" {if $d['user_type'] eq 'SuperAdmin'}selected="selected"
                                            {/if}>Super Administrator</option>
                                    {/if}
                                </select>
                            </div>
                        </div>
                        <div class="form-group {if $d['user_type'] neq 'Sales'}hidden{/if}" id="agentChooser">
                            <label class="col-md-3 control-label">{Lang::T('Agent')}</label>
                            <div class="col-md-9">
                                <select name="root" id="root" class="form-control">
                                    {foreach $agents as $agent}
                                        <option value="{$agent['id']}">{$agent['username']} | {$agent['fullname']} |
                                            {$agent['phone']}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        {if $canAssignAdvancedRole}
                            <div class="form-group">
                                <label class="col-md-3 control-label">{Lang::T('Role')}</label>
                                <div class="col-md-9">
                                    <select name="role_id" id="role_id" class="form-control" onchange="toggleResellerFields()">
                                        <option value="" data-role-type="">{Lang::T('Default')}</option>
                                        {foreach $roles as $role}
                                            <option value="{$role['id']}" data-role-type="{$role['type']}" {if $current_role_id eq $role['id']}selected{/if}>
                                                {$role['name']} ({$role['slug']})
                                            </option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="form-group reseller-field hidden">
                                <label class="col-md-3 control-label">{Lang::T('Parent')}</label>
                                <div class="col-md-9">
                                    <select name="parent_id" class="form-control">
                                        <option value="">None</option>
                                        {foreach $parentUsers as $parentUser}
                                            <option value="{$parentUser['id']}" {if $d['parent_id'] eq $parentUser['id']}selected{/if}>
                                                {$parentUser['username']} | {$parentUser['fullname']} | {$parentUser['user_type']}
                                            </option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="form-group reseller-field hidden">
                                <label class="col-md-3 control-label">{Lang::T('Reseller Level')}</label>
                                <div class="col-md-9">
                                    <input type="number" class="form-control" name="reseller_level" value="{$d['reseller_level']}" min="0" max="{$maxResellerDepth}" {if $_admin['user_type'] neq 'SuperAdmin' && $_admin['user_type'] neq 'Admin'}readonly{/if}>
                                </div>
                            </div>
                        {/if}
                        {if $canAssignAdvancedRole && ($_admin['user_type'] eq 'SuperAdmin' || $_admin['user_type'] eq 'Admin')}
                            <div class="form-group reseller-package-field hidden">
                                <label class="col-md-3 control-label">{Lang::T('Assigned Packages')}</label>
                                <div class="col-md-9">
                                    <div class="well well-sm" style="margin-bottom: 0;">
                                        <div class="row" style="margin-bottom: 8px;">
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control input-sm" id="packageSearch" placeholder="{Lang::T('Search package')}">
                                            </div>
                                            <div class="col-sm-5 text-right">
                                                <button type="button" class="btn btn-xs btn-default" id="selectAllPackages">{Lang::T('Select All')}</button>
                                                <button type="button" class="btn btn-xs btn-default" id="clearAllPackages">{Lang::T('Clear')}</button>
                                            </div>
                                        </div>
                                        <div style="max-height: 220px; overflow-y: auto; border: 1px solid #ddd; background: #fff;">
                                            <table class="table table-condensed table-hover" style="margin-bottom: 0;">
                                                <tbody>
                                                    {foreach $availablePlans as $plan}
                                                        <tr class="package-option" data-package-text="{$plan['name_plan']|lower|escape:'html'} {$plan['type']|lower|escape:'html'} {$plan['routers']|lower|escape:'html'}">
                                                            <td style="width: 30px;">
                                                                <input type="checkbox" name="assigned_plan_ids[]" value="{$plan['id']}"
                                                                    {if isset($assignedPlanMap[$plan['id']])}checked{/if}>
                                                            </td>
                                                            <td>
                                                                <strong>{$plan['name_plan']}</strong>
                                                                <span class="text-muted">{$plan['type']}{if $plan['routers']} | {$plan['routers']}{/if}</span>
                                                            </td>
                                                            <td class="text-right" style="width: 100px;">{Lang::moneyFormat($plan['price'])}</td>
                                                        </tr>
                                                    {/foreach}
                                                    {if count($availablePlans) == 0}
                                                        <tr><td class="text-muted">{Lang::T('No enabled package found')}.</td></tr>
                                                    {/if}
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <span class="help-block">{Lang::T('Only selected packages will be available for this reseller in Quick Add and Recharge')}.</span>
                                </div>
                            </div>
                        {/if}
                    {/if}
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Username')}</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" id="username" name="username"
                                value="{$d['username']}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Password')}</label>
                        <div class="col-md-9">
                            <input type="password" class="form-control" id="password" name="password">
                            <span class="help-block">{Lang::T('Keep Blank to do not change Password')}</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Password')}</label>
                        <div class="col-md-9">
                            <input type="password" class="form-control" id="cpassword" name="cpassword"
                                placeholder="{Lang::T('Confirm Password')}">
                            <span class="help-block">{Lang::T('Keep Blank to do not change Password')}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="form-group text-center">
        <button class="btn btn-primary" onclick="return ask(this, 'Continue the Admin change process?')"
            type="submit">{Lang::T('Save Changes')}</button>
        Or <a href="{Text::url('settings/users')}">{Lang::T('Cancel')}</a>
    </div>
</form>

<script>
    function checkUserType($field) {
        if ($field.value == 'Sales') {
            $('#agentChooser').removeClass('hidden');
        } else {
            $('#agentChooser').addClass('hidden');
        }
        toggleResellerFields();
    }

    function toggleResellerFields() {
        var roleType = $('#role_id option:selected').data('role-type') || '';
        var userType = $('#user_type').val();
        var isReseller = roleType == 'reseller' || (roleType == '' && userType == 'Agent');
        if (isReseller) {
            $('.reseller-field').removeClass('hidden');
            $('.reseller-package-field').removeClass('hidden');
        } else {
            $('.reseller-field').addClass('hidden');
            $('.reseller-package-field').addClass('hidden');
            $('[name="parent_id"]').val('');
            $('[name="reseller_level"]').val('0');
        }
    }

    $(function() {
        toggleResellerFields();
        $('#selectAllPackages').on('click', function() {
            $('.package-option:visible input[type="checkbox"]').prop('checked', true);
        });
        $('#clearAllPackages').on('click', function() {
            $('.reseller-package-field input[type="checkbox"]').prop('checked', false);
        });
        $('#packageSearch').on('keyup', function() {
            var search = ($(this).val() || '').toLowerCase();
            $('.package-option').each(function() {
                var haystack = $(this).data('package-text') || '';
                $(this).toggle(haystack.indexOf(search) !== -1);
            });
            $('.package-type-heading').show();
        });
    });

    function deletePhoto(id) {
        if (confirm('Delete photo?')) {
            if (confirm('Are you sure to delete photo?')) {
                window.location.href = '{Text::url('settings/users-edit/')}'+id+'/deletePhoto'
            }
        }
    }
</script>
{include file="sections/footer.tpl"}
