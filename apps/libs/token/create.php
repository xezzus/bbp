<?php
return function($hashPhone){
  $db = $this->db->pg();
  $options = [
      'cost' => 11,
      'salt' => mcrypt_create_iv(22, MCRYPT_DEV_URANDOM),
  ];
  $string = microtime(1).mt_rand();
  $token = password_hash($string.$this->salt(), PASSWORD_BCRYPT, $options);
  $sql = "update users set token = :token , token_time_create = '".time()."' where phone_hash = :hashPhone returning true as true"; 
  $sql = $db->prepare($sql);
  $sql->execute([':token'=>$token,':hashPhone'=>$hashPhone]);
  $res = $sql->fetch();
  if(isset($res['true'])) return $token;
  else return false;
}
?>
