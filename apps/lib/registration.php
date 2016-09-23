<?php
return [function($phone,$device){

  # преверяем на бан
  if($this->ban->is()){
    self::$http = true;
    return ['msg'=>'it is banned'];
  }

  # переводим значения в HASH
  $hashPhone = $this->hash->create($phone);
  $hashDevice = $this->hash->create($device);

  # проверяем бан: 3 действия за 24 часа
  if($this->request->count(null,null,86400,1) >= 3){
    $this->ban->set(86400);
    self::$http = true;
    return ['msg'=>'it is set banned'];
  }

  # логируем запрос
  if(!$this->request->rec($hashDevice,$hashPhone,1)){
    self::$http = true;
    return ['msg'=>'не получилось залогировать'];
  }

  # проверяем есть ли пользователь в базе, если нет то добавляем
  if(!$this->user->is($hashPhone)) $this->user->rec($phone,$hashPhone);

  # проверяем принадлежит ли устройство другому пользователю
  $whois = $this->device->whois($hashDevice);
  if($whois != false && $whois != $hashPhone){
    # проверяем пыталсяли данный пользовать регистрировать это устройство
    if($this->request->is($hashDevice,$hashPhone,2)){
      # получить время последнего запроса, если был запрос
      $time = $this->request->getLastTime($hashDevice,$hashPhone,2);
      if((time()-$time) >= 30){
        # если активно баним ip
        if($this->device->isActive($hashDevice)){
          # баним ip
          $this->ban->set(86400);
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
      $this->sms->send($hashDevice);
      # Фиксируем попытку захвата
      $this->request->rec($hashDevice,$hashPhone,2);
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
  $this->sms->send($hashDevice);

  # отправить hash
  self::$http = true;
  return ['hashDevice'=>$hashDevice,'hashPhone'=>$hashPhone];
},'PUBLIC'];
?>
