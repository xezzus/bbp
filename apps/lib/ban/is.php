<?php
return function(){
  $ip = $_SERVER['REMOTE_ADDR'];
  $db = $this->db->pg();
  $sql = "select true as true from bans where ip = :ip and time >= :time limit 1";
  $sql = $db->prepare($sql);
  $sql->execute([':ip'=>$ip,':time'=>time()]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
