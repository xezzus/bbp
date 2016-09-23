<?php
return function($hashDevice){
  $db = $this->db->pg();
  $sql = "select phone_hash from devices where device_hash = :hashDevice limit 1";
  $sql = $db->prepare($sql);
  $sql->execute([':hashDevice'=>$hashDevice]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return $res['phone_hash'];
}
?>
