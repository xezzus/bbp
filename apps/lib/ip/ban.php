<?php
return function(){
  $db = $this->db->pg();
  $ip = $_SERVER['REMOTE_ADDR'];
  $sql = "select ban from ips where ip = :ip limit 1";
  $sql = $db->prepare($sql);
  $sql->execute([':ip'=>$ip]);
  $res = $sql->fetch();
  if($res === false){
    $sql = "insert into ips (ip,ban) values (:ip,'".(time()+86400)."') returning true as true;";
    $sql = $db->prepare($sql);
    $sql->execute([':ip'=>$ip]);
    return false;
  } else {
    if($res['ban'] > time()){
      return true;
    } else{
      $sql = "delete from ips where ip = :ip;";
      $sql = $db->prepare($sql);
      $sql->execute([':ip'=>$ip]);
      return false;
    }
  }
}
?>
