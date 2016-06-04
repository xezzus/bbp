<?php
return function($hashDevice,$hashPhone,$power=1){
  $ip = $_SERVER['REMOTE_ADDR'];
  $db = $this->db->pg();
  $sql = "insert into requests (device_hash,phone_hash,time,ip,power) values (:hashDevice,:hashPhone,:time,:ip,:power) returning true as true;";
  $sql = $db->prepare($sql);
  $sql->execute([':time'=>time(),':ip'=>$ip,':hashDevice'=>$hashDevice,':hashPhone'=>$hashPhone,':power'=>$power]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
