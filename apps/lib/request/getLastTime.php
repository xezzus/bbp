<?php
return function($hashDevice,$hashPhone,$type){
  $db = $this->db->pg();
  $sql = "select time from requests where device_hash = :hashDevice and phone_hash = :hashPhone and type = :type order by time desc limit 1";
  $sql = $db->prepare($sql);
  $sql->execute([':hashDevice'=>$hashDevice,':hashPhone'=>$hashPhone,':type'=>$type]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return $res['time'];
}
?>
