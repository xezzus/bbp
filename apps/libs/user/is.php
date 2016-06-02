<?php
return function($hashPhone){
  $db = $this->db->pg();
  $sql = "select true as true from users where phone_hash = :hashPhone limit 1";
  $sql = $db->prepare($sql);
  $sql->execute();
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
