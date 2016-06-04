<?php
return function($phone,$device){

  # проверяем бан: 3 действия за 24 часа
  if($this->request->isBan()) {
    self::$http = true;
    return ['msg'=>'it is banned'];
  }

  # переводим значения в HASH
  $hashPhone = $this->hash->create($phone);
  $hashDevice = $this->hash->create($device);

  # логируем запрос
  $this->request->rec($hashDevice,$hashPhone);

  # проверяем есть ли пользователь в базе, если нет то добавляем
  if(!$this->user->is($hashPhone)) $this->user->rec($phone,$hashPhone);

  # проверяем принадлежит ли устройство другому пользователю
  $whois = $this->device->whois($hashDevice);
  if($whois != false && $whois != $hashPhone){
    # проверяем пыталсяли данный пользовать регистрировать это устройство
    if($this->request->isCapture($hashDevice,$hashPhone)){
      # получить время последнего запроса, если был запрос
      $time = $this->request->getLastTime($hashDevice,$hashPhone);
      if((time()-$time) >= 30){
        # если активно баним ip
        if($this->device->isActive($hashDevice)){
          # баним ip
          $this->request->rec($hashDevice,$hashPhone,3);
          self::$http = true;
          return ['msg'=>'it is banned'];
        } else {
          # присваем устройство другому пользователю
          $this->device->assign($hashDevice,$hashPhone);
        }
      } else {
        # отправляем ошибку
        self::$http = true;
        return ['msg'=>'the device is waiting for confirmation'];
      }
    } else {
      # дективируем устройство
      $this->device->deactivation($hashDevice);
      # отправляем sms
      $this->device->sendSms($hashDevice);
      # Фиксируем попытку захвата
      $this->request->recCapture($hashDevice,$hashPhone);
      # отправляем ошибку
      self::$http = true;
      return ['msg'=>'the device is waiting for confirmation'];
    }
  } 

  # проверить, есть ли запись в devices
  if(!$this->device->is($hashDevice)){
    $this->device->rec($hashDevice,$hashPhone);
  }

  # отправляем sms
  $this->device->sendSms($hashDevice);

  # отправить hash
  self::$http = true;
  return ['hashDevice'=>$hashDevice,'hashPhone'=>$hashPhone];
}
?>
