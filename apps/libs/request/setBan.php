<?php
return function($hashDevice,$hashPhone,$time,$type){
  $ip = $_SERVER['REMOTE_ADDR'];
  $db = $this->db->pg();
  $sql = "insert into requests (device_hash,phone_hash,time,ip,time_ban,type) values (:hashDevice,:hashPhone,:time,:ip,:timeBan,:type) returning true as true;";
  $sql = $db->prepare($sql);
  $sql->execute([':timeBan'=>(time()+$time),':hashDevice'=>$hashDevice,':hashPhone'=>$hashPhone,':time'=>time(),':ip'=>$ip,':type'=>$type]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
