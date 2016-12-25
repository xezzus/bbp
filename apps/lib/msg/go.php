<?php
return [function($msgid,$message){
$this->log('msg/go '.$msgid.' '.$message);
// API access key from Google API's Console
// replace API
$title = 'test';
$to = $msgid;
$registrationIds = array($to);
$msg = array(
  'message' => $message,
  'title' => $title,
  'vibrate' => 1,
  'sound' => 1
);
$fields = array(
  'registration_ids' => $registrationIds,
  'data' => $msg
);
$headers = array (
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
