<?php
return [function($token,$msgCode,$vehicleNumber){
  $this->log('start msg/send');
  # преверяем на бан
  if($this->ban->is()){
    $this->log('msg/send ban');
    self::$http = true;
    return ['msg'=>'it is banned'];
  }

  # проверить токен
  if($this->token->is($token)){
    $this->log('msg/send зашли в токен');
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
        $this->log('msg/send зашли в gps');
        $db = $this->db->pg();

        $user = $this->user->db->getUserByToken($token);
        $userPoint = $this->gps->db->getByToken($token,false);

        // Код сообщения 1?
        $this->log('send msg '.$msgCode);
        if($msgCode == 1){
          $sql = "select phone_hash,msgid from users where phone_hash != '".$user."' and gps = true";
          $res = $db->query($sql)->fetchAll();
          $usersRecipient = [];
          $this->log(json_encode($res));
          foreach($res as $val){
            $point = $this->gps->db->getByUserId($val['phone_hash']);
            $dist = $this->gps->distance($point['latitude'],$point['longitude'],$userPoint['latitude'],$userPoint['longitude']);
            if($dist <= 1000 && $dist >= 0){
              $usersRecipient[] = $val['msgid'];
              $this->log(':msgid: '.$val['msgid']);
              $this->msg->go($val['msgid'],'test');
              $this->log('send msg');
              if($this->msg->db->insert($user,$val['phone_hash'],$msgCode,$vehicleNumber,time())) return 'Отправили сообщение по GPS'; 
            }
          }
          if(empty($usersRecipient)) return 'Никого в радиусе 1км нету';
          else return 'Отправили сообщения по списку';
        } else {
          # ищем по номеру авто
          $sql = "select msgid,phone_hash from users where phone_hash = (select phone_hash from vehicle where \"number\" = :number limit 1) limit 1";
          $sql = $db->prepare($sql);
          $sql->execute([':number'=>$vehicleNumber]);
          $res = $sql->fetch();
          if($res === false) {
            # не нашли
            if($this->msg->db->insert($user,$res['phone_hash'],$msgCode,$vehicleNumber,time())) return 'По этому номеру автомибиля, никого нет.'; 
            else return 'INSERT ERROR 1';
          } else {
            # нашли
            $this->msg->go($res['msgid'],'test');
            if($this->msg->db->insert($user,$res['phone_hash'],$msgCode,$vehicleNumber,time())) return 'Отправили сообщение по номеру автомобиля'; 
            else return 'INSERT ERROR 2';
          }
        }
      }
    }
  } else {
    $this->log('msg/send токен не существует');
    # токен не сущетсвует
    # забанить на 24 часа
    $this->ban->set(86400);
    self::$http = true;
    return ['msg'=>'set is banned 24 hour'];
  }
},'PUBLIC'];
?>
