<?php
return [function($token,$number){
  # преверяем на бан
  if($this->ban->is()){
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
        # удалить авто из базы
        if($this->vehicle->remove($token,$number)){
          return 'SUCCESS';
        } else {
          return ['msg'=>'cannot remove avto'];
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

},'PUBLIC']
?>
