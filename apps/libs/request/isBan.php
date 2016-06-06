<?php
return function($type,$count,$time){
  $ip = $_SERVER['REMOTE_ADDR'];
  $db = $this->db->pg();
  $sql = "select sum(power) as count from requests where ip = :ip and time >= :time, and type = :type";
  $sql = $db->prepare($sql);
  $sql->execute([':ip'=>$ip,':time'=>(time()-$time),':type'=>$type]);
  $res = $sql->fetch();
  if($res['count'] >= $count) return true;
  else return false;
}
?>
