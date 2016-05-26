<?php
return function($phone,$device){
  $db = $this->db->pg();
  $hashPhone = $this->hash->create($phone);
  $hashDevice = $this->hash->create($device);

  # Ban for enter sms
  if($this->ban->is($hashDevice,86400)){
    self::$http = true;
    return ['msg'=>'ban to registration'];
  }

  # check device
  $sql = "select sms, phone_hash from devices where device_hash = :hashDevice limit 1";
  $sql = $db->prepare($sql);
  $sql->execute([':hashDevice'=>$hashDevice]);
  $res = $sql->fetch();

  if($res != false){
    # Check user to device
    if($res['phone_hash'] != $hashPhone){
      $sql = "update devices set activated = false, ban = '".(time()+86400)."' where device_hash = :hashDevice";
      $sql = $db->prepare($sql);
      $sql->execute([':hashDevice'=>$hashDevice]);
      $this->sms->send($res['phone_hash'],$hashDevice);
      self::$http = true;
      return ['msg'=>'Waiting confirm. Please try again in 24 hours.'];
    } else {
      self::$http = true;
      return ['msg'=>'This registration isset'];
    }
  } else {
    # insert
    $sql = "insert into users (phone_hash,phone) values (:hashPhone,:phone) returning true as true;";
    $sql = $db->prepare($sql);
    $sql->execute([':hashPhone'=>$hashPhone,':phone'=>$phone]);
    $res = $sql->fetch();
    if($res === false) $status['user'] = 'isset';
    else $status['user'] = 'insert';
    $sql = "insert into devices (device_hash,phone_hash) values (:hashDevice,:hashPhone)";
    $sql = $db->prepare($sql);
    $sql->execute([':hashDevice'=>$hashDevice,':hashPhone'=>$hashPhone]);
    $res = $sql->fetch();
    if($res === false) $status['device'] = 'isset';
    else $status['device'] = 'insert';

    # Sms
    if($this->sms->send($hashPhone,$hashDevice)) $status['sms'] = 'send';
    else $status['sms'] = 'not send';

    # Response
    self::$http = true;
    return ["hash"=>["phone"=>$hashPhone,"device"=>$hashDevice],"status"=>$status];
  }
}
?>
