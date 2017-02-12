<?php
return [function($token,$msgId){
  $this->log('start msg/subscribe');
  # преверяем на бан
  if($this->ban->is()){
    $this->log('msg/subscribe ban');
    self::$http = true;
    return ['msg'=>'it is banned'];
  }
  $this->log('msg/subscribe begin');

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
        $db = $this->db->pg();
        $sql = "update users set msgid = :msgId where phone_hash = (select phone_hash from users where token = :token limit 1) returning true as true";
        $sql = $db->prepare($sql);
        $sql->execute([':msgId'=>$msgId,':token'=>$token]);
        $res = $sql->fetch();
        if($res === false) return 'ERROR';
        else return 'SUCCESS';
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
