<?php
return function($hashDevice){
  $db = $this->db->pg();
  $sql = "update devices set activated = true where device_hash = :hashDevice";
  $sql = $db->prepare($sql);
  $sql->execute([':hashDevice'=>$hashDevice]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
