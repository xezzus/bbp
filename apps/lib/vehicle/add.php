<?php
return [function($token,$number){
  $this->log('start vehicle/add');
  # преверяем на бан
  if($this->ban->is()){
    $this->log('vehicle/add ban');
    self::$http = true;
    return ['msg'=>'it is banned'];
  }

  # проверить токен
  if($this->token->is($token)){
    # токен существует
    $time = $this->token->getTime($token);
    if($time === false){
      return ['msg'=>'something went wrong'];
    } else {
      $expired = time()-$time;
      if($expired >= 300){
        # токен просрочен
        return 'EXPIRED';
      } else {
        # токен действителен
        if($this->vehicle->count($token) >= 3){
          # у пользователя уже есть 3 авто
          return 'LIMIT';
        } else {
          # добавить авто в базу
          if($this->vehicle->insert($token,$number)){
            return 'SUCCESS';
          } else {
            return ['msg'=>'something went wrong'];
          }
        }
      }
    }
  } else {
    # токен не сущетсвует
    # забанить на 24 часа
    $this->ban->set(86400);
    self::$http = true;
    return ['msg'=>'set is banned 24 hour'];
  }

},'PUBLIC'];
?>
