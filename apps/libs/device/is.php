<?php
return function($hashDevice){
  $db = $this->db->pg();
  $sql = "select true as true where device_hash = :hashDevice limit 1";
  $sql = $db->prepare($sql);
  $sql->execute([':hashDevice'=>$hashDevice]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
