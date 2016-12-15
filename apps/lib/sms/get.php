<?php
return [function($hashDevice,$hashPhone){
  $db = $this->db->pg();
  $sql = "SELECT sms FROM devices WHERE device_hash = $hashDevice;";
  $db->exec($sql);    
  $res = $sql->fetch();
  return ['sms'=> $res];
  return 0;
},'PRIVAT'];
?>