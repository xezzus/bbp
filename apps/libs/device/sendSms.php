<?php
return function($hashDevice){
  $db = $this->db->pg();
  $smsCode = mt_rand(10000,99999);
  $sql = "update devices set sms = :sms, sms_time = :smsTime , sms_counter = sms_counter+1 where device_hash = :hashDevice returning true as true;";
  $sql = $db->prepare($sql);
  $sql->execute([':sms'=>$smsCode,':smsTime'=>time(),':hashDevice'=>$hashDevice]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
