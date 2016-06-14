<?php
return function($hashDevice,$hashPhone,$time,$type=0){
  $ip = $_SERVER['REMOTE_ADDR'];
  $db = $this->db->pg();
  if($hashDevice === null && $hashPhone === null){
    $sql = "select count(0) as count from requests where ip = :ip and time >= :time and type = :type";
    $sql = $db->prepare($sql);
    $sql->execute([':ip'=>$ip,':time'=>(time()-$time),':type'=>$type]);
  } else {
    $sql = "select count(0) as count from requests where device_hash = :hashDevice and phone_hash = :hashPhone and ip = :ip and time >= :time and type = :type";
    $sql = $db->prepare($sql);
    $sql->execute([':ip'=>$ip,':time'=>(time()-$time),':type'=>$type,':hashDevice'=>$hashDevice,':hashPhone'=>$hashPhone]);
  }
  $res = $sql->fetch();
  if($res === false) return false;
  else return $res['count'];
}
?>
