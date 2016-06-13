<?php
return function($time,$type=0){
  $ip = $_SERVER['REMOTE_ADDR'];
  $db = $this->db->pg();
  $sql = "select count(0) as count from requests where ip = :ip and time >= :time";
  $sql = $db->prepare($sql);
  $sql->execute([':ip'=>$ip,':time'=>(time()-$time)]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return $res['count'];
}
?>
