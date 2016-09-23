<?php
return [function($hashDevice,$hashPhone){
  # преверяем на бан
  if($this->ban->is()){
    self::$http = true;
    return ['msg'=>'it is banned'];
  }

  $whois = $this->device->whois($hashDevice);
  # хеши существуют и связаны
  if(!empty($whois) && !empty($hashPhone) && $whois == $hashPhone){
    # да
    # устройство активировано ?
    if($this->activation->is($hashDevice,$hashPhone)){
      # да
      # генерируем токен
      $token = $this->token->create($hashPhone);
      self::$http = true;
      return ['token'=>$token];
    } else {
      # нет
      self::$http = true;
      return 'INACTIVE';
    }
  } else {
    # нет
    # забанить на 24 часа
    $this->ban->set(86400);
    self::$http = true;
    return ['msg'=>'set is banned 24 hour'];
  }
  self::$http = true;
  return true;
},'PUBLIC'];
?>
