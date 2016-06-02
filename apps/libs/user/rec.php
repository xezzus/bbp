<?php
return function($phone,$hashPhone){
  $db = $this->db->pg();
  $sql = "insert into users (phone_hash,phone) values (:hashPhone,:phone) returning true as true;";
  $sql = $db->prepare($sql);
  $sql->execute([':hashPhone'=>$hashPhone,':phone'=>$phone]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
