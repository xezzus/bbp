<?php
return [function($msgid,$message){
// API access key from Google API's Console
// replace API
$title = 'test';
$to = 'e4K1BbL5QVg:APA91bG2Jf8ok9sB8CQoHUAp6fl-xKvoeQTWh64Kz049btYIN9B8cQhPc-PURQZl-P3D3nysaVAPFEb2wA1ymZYLQLM_Dp9-PPnZhyjqeljgdwyKNtQtx4djmD3AsDs4kOj8Z2P1lyoM';
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
'Authorization: key=AIzaSyAYNQgPZQno3E0xYvIevLclISjzxb9DBSk',
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
