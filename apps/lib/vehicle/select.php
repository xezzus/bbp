<?php
return function($token){
  $db = $this->db->pg();
  $sql = "select \"number\" from vehicle where phone_hash = (select phone_hash from users where token = :token limit 1) limit 3";
  $sql = $db->prepare($sql);
  $sql->execute([':token'=>$token]);
  $res = $sql->fetchAll();
  if($res === false) return false;
  else return $res;
}
?>
