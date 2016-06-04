<?php
return function($hashDevice,$hashPhone){
  $ip = $_SERVER['REMOTE_ADDR'];
  $db = $this->db->pg();
  $sql = "insert into requests (device_hash,phone_hash,time,ip,capture) values (:hashDevice,:hashPhone,:time,:ip,true) returning true as true;";
  $sql = $db->prepare($sql);
  $sql->execute([':time'=>time(),':ip'=>$ip,':hashDevice'=>$hashDevice,':hashPhone'=>$hashPhone]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
