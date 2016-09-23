<?php
return function($token,$number){
  $db = $this->db->pg();
  $sql = "delete from vehicle where phone_hash = (select phone_hash from users where token = :token limit 1) and \"number\" = :number returning true as true";
  $sql = $db->prepare($sql);
  $sql->execute([':token'=>$token,':number'=>$number]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
