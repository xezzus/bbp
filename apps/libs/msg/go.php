<?php
return [function($msgid,$message){
// API access key from Google API's Console
// replace API
$title = 'test';
$to = 'eq6Bkr0uA3I:APA91bHu9dl72DGEI6Hazcx0jEjAVpQZbyA3WbBmngWru_3rl1RWfdlvQbiINXQO_WXbuWTDtLkPvfNkzNGlMo-dTtP4yk0uLi-H4rOzhovs5671SGNaTrPrnKapd_5QxRZ5JlffJUJh';
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
'Authorization: key=AIzaSyDx2WLQakxBTEVgSj-HEyDy_eXdcJpXXao',
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