<?php
return function($token,$number){
  $db = $this->db->pg();
  $sql = "insert into vehicle (phone_hash,\"number\",time_create) values ((select phone_hash from users where token = :token limit 1),:number,:time) returning time_create as time";
  $sql = $db->prepare($sql);
  $sql->execute([':token'=>$token,':number'=>$number,':time'=>time()]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return $res['time'];
}
?>
