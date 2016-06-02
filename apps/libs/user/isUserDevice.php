<?php
return function($hashDevice,$hashPhone){
  $db = $this->db->pg();
  $sql = "select true as true from requests where device_hash = :hashDevice and phone_hash = :hashPhone limit 1";
  $sql = $db->prepare($sql);
  $sql->execute([':hashDevice'=>$hashDevice,':hashPhone'=>$hashPhone]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
