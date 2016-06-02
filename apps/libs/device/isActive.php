<?php
return function($hashDevice){
  $db = $this->db->pg();
  $sql = "select true as true from requests where device_hash = :hashDevice and activted = true limit 1";
  $sql = $db->prepare($sql);
  $sql->execute([':hashDevice'=>$hashDevice]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
