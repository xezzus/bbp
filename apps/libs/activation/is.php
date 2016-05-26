<?php
return function($hashPhone,$hashDevice){
  $db = $this->db->pg();
  $sql = "select true as true from devices where device_hash = :hashDevice and phone_hash = :hashPhone and activated = true limit 1";
  $sql = $db->prepare($sql);
  $sql->execute([':hashDevice'=>$hashDevice,':hashPhone'=>$hashPhone]);
  $res = $sql->fetch();

  # Response
  self::$http = true;
  if($res === false) { 
    return false; 
  } else {
    return true;
  }
}
?>
