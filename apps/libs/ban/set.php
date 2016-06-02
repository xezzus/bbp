<?php
return function(){
  $db = $this->db->pg();
  $ip = $_SERVER['REMOTE_ADDR'];
  $sql = "update ban set time = '".(time()+86400)."' , counter = 3 where ip = :ip returning true as true;";
  $sql = $db->prepare($sql);
  $sql->execute([':ip'=>$ip]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
