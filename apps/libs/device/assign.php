<?php
return function($hashDevice,$hashPhone){
  $db = $this->db->pg();
  $sql = "update devices set phone_hash = :hashPhone where device_hash = :hashDevice returning true as true;";
  $sql = $db->prepare($sql);
  $sql->execute([':hashPhone'=>$hashPhone,':hashDevice'=>$hashDevice]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
