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
    # превышен лимит 3 sms в сутки?
    if($this->request->count($hashDevice,$hashPhone,86400,4) >= 3){
      # да
      self::$http = true;
      return 'LIMIT';
    } else {
      # нет
      # последнее sms отправлено меньше чем 3 минуты назад?
      $lastTime = $this->request->getLastTime($hashDevice,$hashPhone,4);
      $restTime = 90-(time()-$lastTime);
      if($lastTime !== false && $restTime > 0){
        # да
        self::$http = true;
        return ['msg'=>'rest time','time'=>$restTime];
      } else {
        # нет
        # отправляем sms
        $this->sms->send($hashDevice);
        # записываем отправку
        $this->request->rec($hashDevice,$hashPhone,4);
        self::$http = true;
        return 'SUCCESS';
      }
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
