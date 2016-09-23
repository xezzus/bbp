<?php
return function($token){
  $db = $this->db->pg();
  $sql = "select count(0) as count from vehicle where phone_hash = (select phone_hash from users where token = :token limit 1)";
  $sql = $db->prepare($sql);
  $sql->execute([':token'=>$token]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return $res['count'];
}
?>
