<?php
return function(){
  $ip = $_SERVER['REMOTE_ADDR'];
  $db = $this->db->pg();
  $sql = "select sum(power) as count from requests where ip = :ip and time >= :time";
  $sql = $db->prepare($sql);
  $sql->execute([':ip'=>$ip,':time'=>(time()-86400)]);
  $res = $sql->fetch();
  if($res['count'] >= 3) return true;
  else return false;
}
?>
