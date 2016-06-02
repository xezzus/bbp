<?php
return function($hashDevice,$hashPhone){
  $db = $this->db->pg();
  $sql = "insert into devices (device_hash,phone_hash) values (:hashDevice,:hashPhone) returning true as true";
  $sql = $db->prepare($sql);
  $sql->execute([':hashDevice'=>$hashDevice,':hashPhone'=>$hashPhone]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
