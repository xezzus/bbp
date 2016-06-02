<?php
return function($hashDevice){
  $db = $this->db->pg();
  $sql = "update devices set activated = false where device_hash = :hashDevice returnint true as true;";
  $sql = $db->prepare($sql);
  $sql->execute([':hashDevice'=>$hashDevice]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
