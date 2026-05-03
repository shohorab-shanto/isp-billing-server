<?php

register_menu("Verimor SMS Gateway", true, "verimor_sms", 'AFTER_SETTINGS', 'glyphicon glyphicon-comment', '', '', ['Admin', 'SuperAdmin']);

#register_hook('send_sms', 'verimor_sms_send');


function verimor_sms()
{
    global $ui, $admin;
    _admin();

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $d = ORM::for_table('tbl_appconfig')->where('setting', 'verimorsms_username')->find_one();
        if ($d) {
            $d->value = _post('verimorsms_username');
            $d->save();
        } else {
            $d = ORM::for_table('tbl_appconfig')->create();
            $d->setting = 'verimorsms_username';
            $d->value = _post('verimorsms_username');
            $d->save();
        }
        $d = ORM::for_table('tbl_appconfig')->where('setting', 'verimorsms_password')->find_one();
        if ($d) {
            $d->value = _post('verimorsms_password');
            $d->save();
        } else {
            $d = ORM::for_table('tbl_appconfig')->create();
            $d->setting = 'verimorsms_password';
            $d->value = _post('verimorsms_password');
            $d->save();
        }
        $d = ORM::for_table('tbl_appconfig')->where('setting', 'sms_url')->find_one();
        if ($d) {
            $d->value = U . "plugin/verimor_sms_send&to=[number]&msg=[text]&secret=" . md5(_post('verimorsms_password'));
            $d->save();
        } else {
            $d = ORM::for_table('tbl_appconfig')->create();
            $d->setting = 'sms_url';
            $d->value = _post('sms_url');
            $d->save();
        }
        r2(getUrl('plugin/verimor_sms'), 's', 'Configuration saved');
    }

    $ui->assign('_title', 'Verimor SMS Gateway');
    $ui->assign('_system_menu', 'plugin/verimor_sms');
    $admin = Admin::_info();
    $ui->assign('_admin', $admin);
    $ui->display('verimor_sms.tpl');
}


function verimor_sms_send()
{
    global $config;
    $to = alphanumeric(_req('to'));
    $msg = _req('msg');
    $secret = _req('secret');
    if ($secret != md5($config['verimorsms_password'])) {
        showResult(false, 'Invalid secret');
    }
    $data = [
        "username" => $config['verimorsms_username'], // https://oim.verimor.com.tr/sms_settings/edit adresinden öğrenebilirsiniz.
        "password" => $config['verimorsms_password'], // https://oim.verimor.com.tr/sms_settings/edit adresinden belirlemeniz gerekir.
        //"source_addr" => $source_addr, // Gönderici başlığı, https://oim.verimor.com.tr/headers adresinde onaylanmış olmalı, değilse 400 hatası alırsınız.
        //    "valid_for" => "48:00",
        //    "send_at" => "2015-02-20 16:06:00",
        //    "datacoding" => "0",
        "custom_id" => date("YmdHis") . "." . time(),
        "messages" => [
            [
                "msg" => $msg,
                "dest" => $to
            ]
        ]
    ];
    $result  = Http::postJsonData("https://sms.verimor.com.tr/v2/send.json", $data);
    $json = json_decode($result, true);
    if ($json) {
        showResult(true, '', $json);
    } else {
        showResult(false, '', $result);
    }
}
