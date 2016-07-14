<?php
return [function($msgid,$message){
// API access key from Google API's Console
// replace API
$title = 'test';
<<<<<<< HEAD
$to = 'e4K1BbL5QVg:APA91bG2Jf8ok9sB8CQoHUAp6fl-xKvoeQTWh64Kz049btYIN9B8cQhPc-PURQZl-P3D3nysaVAPFEb2wA1ymZYLQLM_Dp9-PPnZhyjqeljgdwyKNtQtx4djmD3AsDs4kOj8Z2P1lyoM';
=======
$to = $msgid;
>>>>>>> 51929de68b4254cd2b34803d2de9d428c5ce9553
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
<<<<<<< HEAD
'Authorization: key=AIzaSyBgFDvm1VzJemH3y-AXp8CdITBssRPvn3k',
=======
'Authorization: key=AIzaSyDDrKkus9wBtlXB7-tEoUO5c38myuyuy2s',
>>>>>>> 51929de68b4254cd2b34803d2de9d428c5ce9553
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
