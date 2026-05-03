<div class="row">
    {if in_array($_admin['user_type'],['SuperAdmin','Admin', 'Report'])}
        <div class="col-lg-3 col-xs-6">
            <div class="small-box" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); border-radius: 12px; box-shadow: 0 4px 15px rgba(245, 87, 108, 0.4);">
                <div class="inner">
                    <h3 class="text-bold" style="font-size: 28px; color: white; margin: 0;"><sup style="font-size: 16px;">{$_c['currency_code']}</sup>
                        {number_format($iday,0,$_c['dec_point'],$_c['thousands_sep'])}</h3>
                    <p style="color: rgba(255,255,255,0.9); margin: 5px 0 0 0; font-size: 14px;">{Lang::T('Income Today')}</p>
                </div>
                <div class="icon">
                    <i class="ion ion-clock" style="color: rgba(255,255,255,0.3); font-size: 60px;"></i>
                </div>
                <a href="{Text::url('reports/by-date')}" class="small-box-footer" style="background: rgba(0,0,0,0.1); color: white;">{Lang::T('View Details')} <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-xs-6">
            <div class="small-box" style="background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); border-radius: 12px; box-shadow: 0 4px 15px rgba(17, 153, 142, 0.4);">
                <div class="inner">
                    <h3 class="text-bold" style="font-size: 28px; color: white; margin: 0;"><sup style="font-size: 16px;">{$_c['currency_code']}</sup>
                        {number_format($imonth,0,$_c['dec_point'],$_c['thousands_sep'])}</h3>
                    <p style="color: rgba(255,255,255,0.9); margin: 5px 0 0 0; font-size: 14px;">{Lang::T('Income This Month')}</p>
                </div>
                <div class="icon">
                    <i class="ion ion-android-calendar" style="color: rgba(255,255,255,0.3); font-size: 60px;"></i>
                </div>
                <a href="{Text::url('reports/by-period')}" class="small-box-footer" style="background: rgba(0,0,0,0.1); color: white;">{Lang::T('View Details')} <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
    {/if}
    <div class="col-lg-3 col-xs-6">
        <div class="small-box" style="background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); border-radius: 12px; box-shadow: 0 4px 15px rgba(250, 112, 154, 0.4);">
            <div class="inner">
                <h3 class="text-bold" style="font-size: 28px; color: white; margin: 0;">{$u_act}</h3>
                <p style="color: rgba(255,255,255,0.9); margin: 5px 0 0 0; font-size: 14px;">{Lang::T('Active Customers')}</p>
            </div>
            <div class="icon">
                <i class="ion ion-person" style="color: rgba(255,255,255,0.3); font-size: 60px;"></i>
            </div>
            <a href="{Text::url('plan/list')}" class="small-box-footer" style="background: rgba(0,0,0,0.1); color: white;">{Lang::T('View Details')} <i class="fa fa-arrow-circle-right"></i></a>
        </div>
    </div>
    <div class="col-lg-3 col-xs-6">
        <div class="small-box" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); border-radius: 12px; box-shadow: 0 4px 15px rgba(245, 87, 108, 0.4);">
            <div class="inner">
                <h3 class="text-bold" style="font-size: 28px; color: white; margin: 0;">{$u_all-$u_act}</h3>
                <p style="color: rgba(255,255,255,0.9); margin: 5px 0 0 0; font-size: 14px;">{Lang::T('Expired Customers')}</p>
            </div>
            <div class="icon">
                <i class="ion ion-person-stalker" style="color: rgba(255,255,255,0.3); font-size: 60px;"></i>
            </div>
            <a href="{Text::url('plan/list')}" class="small-box-footer" style="background: rgba(0,0,0,0.1); color: white;">{Lang::T('View Details')} <i class="fa fa-arrow-circle-right"></i></a>
        </div>
    </div>
    <div class="col-lg-3 col-xs-6">
        <div class="small-box" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); border-radius: 12px; box-shadow: 0 4px 15px rgba(79, 172, 254, 0.4);">
            <div class="inner">
                <h3 class="text-bold" style="font-size: 28px; color: white; margin: 0;">{$c_all}</h3>
                <p style="color: rgba(255,255,255,0.9); margin: 5px 0 0 0; font-size: 14px;">{Lang::T('Total Customers')}</p>
            </div>
            <div class="icon">
                <i class="ion ion-android-people" style="color: rgba(255,255,255,0.3); font-size: 60px;"></i>
            </div>
            <a href="{Text::url('customers/list')}" class="small-box-footer" style="background: rgba(0,0,0,0.1); color: white;">{Lang::T('View Details')} <i class="fa fa-arrow-circle-right"></i></a>
        </div>
    </div>
    <div class="col-lg-3 col-xs-6">
        <div class="small-box" style="background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%); border-radius: 12px; box-shadow: 0 4px 15px rgba(235, 51, 73, 0.4);">
            <div class="inner">
                <h3 class="text-bold" style="font-size: 28px; color: white; margin: 0;">{$c_disabled}</h3>
                <p style="color: rgba(255,255,255,0.9); margin: 5px 0 0 0; font-size: 14px;">{Lang::T('Disabled Customers')}</p>
            </div>
            <div class="icon">
                <i class="ion ion-android-lock" style="color: rgba(255,255,255,0.3); font-size: 60px;"></i>
            </div>
            <a href="{Text::url('customers/list')}" class="small-box-footer" style="background: rgba(0,0,0,0.1); color: white;">{Lang::T('View Details')} <i class="fa fa-arrow-circle-right"></i></a>
        </div>
    </div>
    {* Online users counter temporarily disabled from dashboard.
    <div class="col-lg-3 col-xs-6">
        <div class="small-box" style="background: linear-gradient(135deg, #00c6ff 0%, #0072ff 100%); border-radius: 12px; box-shadow: 0 4px 15px rgba(0, 198, 255, 0.4);">
            <div class="inner">
                <h3 class="text-bold" style="font-size: 28px; color: white; margin: 0;">
                    <span id="online-users-count" style="display: none;">0</span>
                    <span id="online-users-loading">
                        <i class="fa fa-spinner fa-spin" style="font-size: 24px;"></i>
                    </span>
                </h3>
                <p style="color: rgba(255,255,255,0.9); margin: 5px 0 0 0; font-size: 14px;">{Lang::T('Online Users')}</p>
            </div>
            <div class="icon">
                <i class="ion ion-wifi" style="color: rgba(255,255,255,0.3); font-size: 60px;"></i>
            </div>
            <a href="{Text::url('plan/active')}" class="small-box-footer" style="background: rgba(0,0,0,0.1); color: white;">{Lang::T('View Details')} <i class="fa fa-arrow-circle-right"></i></a>
        </div>
    </div>
    *}
</div>
{* Online users counter script temporarily disabled.
<script>
    (function() {
        function showOnlineUsersCount(count) {
            var countEl = document.getElementById('online-users-count');
            var loadingEl = document.getElementById('online-users-loading');

            if (countEl) {
                countEl.textContent = count;
                countEl.style.display = '';
            }

            if (loadingEl) {
                loadingEl.style.display = 'none';
            }
        }

        function loadOnlineUsersCount() {
            var countEl = document.getElementById('online-users-count');
            var loadingEl = document.getElementById('online-users-loading');

            if (countEl) {
                countEl.style.display = 'none';
            }

            if (loadingEl) {
                loadingEl.style.display = '';
            }

            var request = new XMLHttpRequest();
            request.open('GET', "?_route=autoload/count_online_users", true);
            request.setRequestHeader('Accept', 'application/json');
            request.onreadystatechange = function() {
                if (request.readyState !== 4) {
                    return;
                }

                if (request.status < 200 || request.status >= 300) {
                    showOnlineUsersCount(0);
                    return;
                }

                try {
                    var data = JSON.parse(request.responseText);
                    showOnlineUsersCount(data && data.count !== undefined ? data.count : 0);
                } catch (e) {
                    showOnlineUsersCount(0);
                }
            };
            request.onerror = function() {
                showOnlineUsersCount(0);
            };
            request.send();
        }

        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', loadOnlineUsersCount);
        } else {
            loadOnlineUsersCount();
        }
    })();
</script>
*}
