<?php
return function($hashDevice,$time){
  $db = $this->db->pg();
  $sql = "select true as true from devices where device_hash = :hashDevice and ban > ".time()." limit 1";
  $sql = $db->prepare($sql);
  $sql->execute([':hashDevice'=>$hashDevice]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
