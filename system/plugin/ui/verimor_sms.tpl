{include file="sections/header.tpl"}

<form class="form" method="post" role="form" action="{$_url}plugin/verimor_sms">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">
                        Configuration
                    </h3>
                </div>
                <div class="box-body with-border">
                    <div class="form-group">
                        <label>Username</label>
                        <input type="text" class="form-control" name="verimorsms_username" required
                            value="{$_c['verimorsms_username']}" required>
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <input type="text" class="form-control" name="verimorsms_password" required
                            value="{$_c['verimorsms_password']}">
                    </div>
                </div>
                <div class="box-footer">
                    <div class="row">
                        <div class="col-xs-12">
                            <button class="btn btn-primary btn-sm btn-block" type="submit">Save</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>


<form class="form" method="get" role="form" action="{$_url}plugin/verimor_sms_send">
    <input type="hidden" class="form-control" name="_route" value="plugin/verimor_sms_send">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">
                        Testing
                    </h3>
                </div>
                <div class="box-body with-border">
                    <div class="form-group">
                        <label>To</label>
                        <input type="text" class="form-control" name="to" required>
                    </div>
                    <div class="form-group">
                        <label>Message</label>
                        <input type="text" class="form-control" name="msg" required>
                    </div>
                    <div class="form-group">
                        <label>secret</label>
                        <input type="text" class="form-control" name="secret" value="{md5($_c['verimorsms_password'])}" readonly required>
                    </div>
                </div>
                <div class="box-footer">
                    <div class="form-group">
                        <input type="text" onclick="this.select()" class="form-control" value="{$_url}plugin/verimor_sms_send&to=[number]&msg=[text]&secret={md5($_c['verimorsms_password'])}" required>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <button class="btn btn-primary btn-sm btn-block" type="submit">Send SMS</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>


{include file="sections/footer.tpl"}