<?php
return function($token){
  $db = $this->db->pg();
  $sql = "select token_time_create as time from users where token = :token limit 1";
  $sql = $db->prepare($sql);
  $sql->execute([':token'=>$token]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return $res['time'];
}
?>
