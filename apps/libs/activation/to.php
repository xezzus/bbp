<?php
return function($hashPhone,$hashDevice,$sms){
  $whois = $this->device->whois($hashDevice);
  # хеши существуют и связаны
  if(!empty($whois) && !empty($hashPhone) && $whois == $hashPhone){
    # да
    # Совпадаютли коды
    if($this->device->isSmsCode($hashPhone,$hashDevice,$sms)){
      # да
      if($this->device->activate($hashDevice)){
        # получилось активировать
        self::$http = true;
        return ['token'=>'вернули токен'];
      } else {
        # не получилось активировать
        self::$http = true;
        return ['msg'=>'не получилось активировать'];
      }
    } else {
      # нет
    }
  } else {
    # нет
  }
}
?>
