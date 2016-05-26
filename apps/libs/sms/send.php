<?php
return function($hashPhone,$hashDevice){
  $db = $this->db->pg();
  $sms = 'test';
  $sql = "update devices set sms = :sms, sms_time = '".time()."', sms_counter = sms_counter+1 where device_hash = :hashDevice and phone_hash = :hashPhone and activated = false returning true as true;";
  $sql = $db->prepare($sql);
  $sql->execute([':sms'=>$sms,':hashDevice'=>$hashDevice,':hashPhone'=>$hashPhone]);
  $res = $sql->fetch();
  self::$http = true;
  if($res === false) { return false; }
  else return true;
}
?>
