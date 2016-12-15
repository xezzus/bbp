<?php
return [function($hashDevice,$hashPhone){
  $db = $this->db->pg();
  $sql = "SELECT sms FROM devices WHERE device_hash = $hashDevice;";
  $db->exec($sql);    
  return ['msg'=>'set is banned 24 hour'];

},'PUBLIC'];
?>