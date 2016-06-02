<?php
return function(){
  $db = $this->db->pg();
  $ip = $_SERVER['REMOTE_ADDR'];
  $sql = "select time,counter from ban where ip = :ip and time > '".time()."' and counter >= 3 limit 1;";
  $sql = $db->prepare($sql);
  $sql->execute([':ip'=>$ip]);
  $res = $sql->fetch();
  if($res === false) {
    if($res['time'] > 0 || $res['counter'] > 0){
      $sql = "update ban set time = 0 , counter = 0 where ip = :ip";
      $sql = $db->prepare($sql);
      $sql->execute([':ip'=>$ip]);
    }
    return false;
  }
  else return true;
}
?>
