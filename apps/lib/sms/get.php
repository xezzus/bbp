<?php

return function($hashDevice){

  $db = $this->db->pg();
  $sql = "SELECT sms FROM devices WHERE device_hash = :hashDevice";
  $sql = $db->prepare($sql);
  $sql->execute([':hashDevice'=>$hashDevice]);
  $res = $sql->fetch();
  return ['sms'=> $res];

}
?>