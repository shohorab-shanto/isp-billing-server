function sms_sendThirdParty($phone, $message)
{
    $url = 'https://api.sms.net.bd/sendsms';
    $apiKey = sms_getConfigValue('sms_api_key');
    $senderId = sms_getConfigValue('sms_sender_id'); // optional

    $phone = preg_replace('/\D+/', '', $phone);

    // 017XXXXXXXX -> 88017XXXXXXXX
    if (strpos($phone, '0') === 0) {
        $phone = '880' . substr($phone, 1);
    }

    $postFields = [
        'api_key' => $apiKey,
        'msg'     => $message,
        'to'      => $phone,
    ];

    if (!empty($senderId)) {
        $postFields['sender_id'] = $senderId;
    }

    $ch = curl_init();

    curl_setopt_array($ch, [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => $postFields,
        CURLOPT_TIMEOUT => 30,
    ]);

    $response = curl_exec($ch);
    $error = curl_error($ch);
    $httpCode = (int) curl_getinfo($ch, CURLINFO_HTTP_CODE);

    curl_close($ch);

    return [
        'ok' => ($error === '' && $httpCode >= 200 && $httpCode < 300),
        'http_code' => $httpCode,
        'error' => $error,
        'response' => (string) $response,
    ];
}