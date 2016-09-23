<?php
return function($time){
  $ip = $_SERVER['REMOTE_ADDR'];
  $db = $this->db->pg();
  $sql = "insert into bans (ip,time) values (:ip,:time) returning id;";
  $sql = $db->prepare($sql);
  $sql->execute([':time'=>time()+$time,':ip'=>$ip]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
