<?php
return function($hashDevice){
  $db = $this->db->pg();
  $sql = "select true as true from devices where device_hash = :hashDevice and activated = true limit 1";
  $sql = $db->prepare($sql);
  $sql->execute([':hashDevice'=>$hashDevice]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
