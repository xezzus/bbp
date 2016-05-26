<?php
return function($hashPhone,$hashDevice,$sms){
  $db = $this->db->pg();
  $sql = "select sms, phone_hash from devices where device_hash = :hashDevice limit 1";
  $sql = $db->prepare($sql);
  $sql->execute([':hashDevice'=>$hashDevice]);
  $res = $sql->fetch();

  # Ban for enter sms
  if($this->ban->is($hashDevice,900)){
    self::$http = true;
    return ['msg'=>'ban to sms'];
  }

  if($res === false) { 
    if($this->ip->ban()) {
      self::$http = true;
      return ['msg'=>'ban to ip'];
    }
    self::$http = true;
    return ['msg'=>'repeat registration']; 
  }

  # Enter sms
  if(empty($sms) || $sms != $res['sms']){
    self::$http = true;
    $sql = "update devices set sms_counter_enter = sms_counter_enter+1 where device_hash = :hashDevice and phone_hash = :hashPhone returning sms_counter_enter;";
    $sql = $db->prepare($sql);
    $sql->execute([':hashDevice'=>$hashDevice,':hashPhone'=>$hashPhone]);
    $res = $sql->fetch();
    if($res['sms_counter_enter'] > 3){
      $sql = "update devices set ban = '".(time()+900)."' where device_hash = :hashDevice and phone_hash = :hashPhone returning true as true;";
      $sql = $db->prepare($sql);
      $sql->execute([':hashDevice'=>$hashDevice,':hashPhone'=>$hashPhone]);
      $res = $sql->fetch();
      if($res === false) return false;
      else return ['msg'=>'ban'];
    }
    return ['msg'=>'incorrect code'];
  }

  if(!$token = $this->token->create($hashPhone)) {
    self::$http = true;
    return false;
  }

  # Set Activated
  $sql = "update devices set activated = true where device_hash = :hashDevice and phone_hash = :hashPhone and activated = false returning true as true;";
  $sql = $db->prepare($sql);
  $sql->execute([':hashDevice'=>$hashDevice,':hashPhone'=>$hashPhone]);
  $res = $sql->fetch();

  self::$http = true;
  if($res === false) return false;
  else return ['token'=>$token];
}
?>
