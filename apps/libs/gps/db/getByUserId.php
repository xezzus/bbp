<?php
return function($userId){
  $db = $this->db->pg();
  $sql = "select latitude,longitude from gps where user_id = :userId and used = true order by time desc limit 1";
  $sql = $db->prepare($sql);
  $sql->execute([':userId'=>$userId]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return $res;
}
?>
