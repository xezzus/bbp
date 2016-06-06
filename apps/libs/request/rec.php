<?php
return function($hashDevice,$hashPhone,$type,$power=1){
  $ip = $_SERVER['REMOTE_ADDR'];
  $db = $this->db->pg();
  $sql = "insert into requests (device_hash,phone_hash,time,ip,power,type) values (:hashDevice,:hashPhone,:time,:ip,:power,:type) returning true as true;";
  $sql = $db->prepare($sql);
  $sql->execute([':time'=>time(),':ip'=>$ip,':hashDevice'=>$hashDevice,':hashPhone'=>$hashPhone,':power'=>$power,':type'=>$type]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
