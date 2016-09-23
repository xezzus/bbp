<?php
return function($hashDevice,$smsCode){
  $db = $this->db->pg();
  $sql = "select true as true from devices where device_hash = :hashDevice and sms = :sms limit 1";
  $sql = $db->prepare($sql);
  $sql->execute([':hashDevice'=>$hashDevice,':sms'=>$smsCode]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
