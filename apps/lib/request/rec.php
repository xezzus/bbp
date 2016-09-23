<?php
return function($hashDevice,$hashPhone,$type){
  $ip = $_SERVER['REMOTE_ADDR'];
  $db = $this->db->pg();
  $sql = "insert into requests (device_hash,phone_hash,time,ip,type) values (:hashDevice,:hashPhone,:time,:ip,:type) returning true as true;";
  $sql = $db->prepare($sql);
  $sql->execute([':time'=>time(),':ip'=>$ip,':hashDevice'=>$hashDevice,':hashPhone'=>$hashPhone,':type'=>$type]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
