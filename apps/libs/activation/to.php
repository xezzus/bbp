<?php
return function($hashPhone,$hashDevice,$sms){
  # преверяем на бан
  if($this->request->isBan()){
    self::$http = true;
    return ['msg'=>'it is banned'];
  }

  $whois = $this->device->whois($hashDevice);
  # хеши существуют и связаны
  if(!empty($whois) && !empty($hashPhone) && $whois == $hashPhone){
    # да
    # код введен 3 раза за 15 минут?
    if($this->request->count(900,3) < 3){
      # да
      # логируем ыыод кода
      if($this->request->rec($hashDevice,$hashPhone,3)){
        # Совпадаютли коды
        if($this->device->isSmsCode($hashDevice,$sms)){
          # да
          # активируем устройство
          if($this->device->activate($hashDevice)){
            # получилось активировать
            $token = $this->token->create($hashPhone);
            self::$http = true;
            return ['token'=>$token];
          } else {
            # не получилось активировать
            self::$http = true;
            return ['msg'=>'not activated'];
          }
        } else {
          self::$http = true;
          return ['msg'=>'wrong'];
        }
      } else {
        self::$http = true;
        return ['msg'=>'not logged'];
      }
    } else {
      # забанить на 15 минут
      $this->request->setBan($hashDevice,$hashPhone,900,3);
      self::$http = true;
      return ['msg'=>'set is banned 15 minutes'];
    }
  } else {
    # забанить на 24 часа
    $this->request->setBan($hashDevice,$hashPhone,86400,3);
    self::$http = true;
    return ['msg'=>'set is banned 24 hour'];
  }
}
?>
