<?php
return function($hashDevice){
  $db = $this->db->pg();
  $smsCode = mt_rand(10000,99999);
  $sql = "update devices set sms = :sms where device_hash = :hashDevice returning true as true;";
  $sql = $db->prepare($sql);
  $sql->execute([':sms'=>$smsCode,':hashDevice'=>$hashDevice]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
