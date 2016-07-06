<?php
return function($token){
  $db = $this->db->pg();
  $user = $this->user->db->getUserByToken($token);
  $sql = "select latitude,longitude from gps where user_id = '{$user}' and used = true order by time desc limit 1";
  $r = $db->query($sql)->fetch();
  if($r === false) return false;
  else return $r;
}
?>
