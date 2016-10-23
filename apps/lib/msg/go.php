<?php
return [function($msgid,$message){
// API access key from Google API's Console
// replace API
$title = 'test';
$to = 'dI_tgmpogbE:APA91bGwlftEGM8tGf4kt6umzOqNPnH-1lPLkBc1OQl12qIT7he4G3XG2gt3bIPcL3evGvaKF9dPrdlufmNPb1YTCRnq8aNaG8Gw5qHwo_BMvmv31txRqhURj4E0kw5YD9mB5Uqqmv6r';
$registrationIds = array($to);
$msg = array
(
'message' => $message,
'title' => $title,
'vibrate' => 1,
'sound' => 1

// you can also add images, additionalData
);
$fields = array
(
'registration_ids' => $registrationIds,
'data' => $msg
);
$headers = array
(
'Authorization: key=AIzaSyAv5FUXMx7YN_fguNL1YQzB4w2YzFXZeac',
'Content-Type: application/json'
);
$ch = curl_init();
curl_setopt( $ch,CURLOPT_URL, 'https://android.googleapis.com/gcm/send' );
curl_setopt( $ch,CURLOPT_POST, true );
curl_setopt( $ch,CURLOPT_HTTPHEADER, $headers );
curl_setopt( $ch,CURLOPT_RETURNTRANSFER, true );
curl_setopt( $ch,CURLOPT_SSL_VERIFYPEER, false );
curl_setopt( $ch,CURLOPT_POSTFIELDS, json_encode( $fields ) );
$result = curl_exec($ch );
curl_close( $ch );
return $result;
},'PUBLIC'];
?>
