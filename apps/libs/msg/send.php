<?php
return [function($token,$msgCode,$vehicleNumber){
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
        $db = $this->db->pg();

        $user = $this->user->db->getUserByToken($token);
        $userPoint = $this->gps->db->getByToken($token);

        if($msgCode == 1){
          $sql = "select phone_hash,msgid from users where gps = true";
          $res = $db->query($sql)->fetchAll();
          $usersRecipient = [];
          foreach($res as $val){
            $point = $this->gps->db->getByUserId($val['phone_hash']);
            $dist = $this->gps->distance($userPoint['latitude'],$userPoint['longitude'],$point['latitude'],$point['longitude']);
            if($dist <= 1000 && $dist >= 1){
              $usersRecipient[] = $val['msgid'];
            }
          }
          $this->msg->go($usersRecipient);
        } else {
          # ищем по номеру авто
          $sql = "select msgId from users where phone_hash = (select phone_hash from vehicles where \"number\" = :number limit 1) limit 1";
          $sql = $db->prepare($sql);
          $sql->execute([':number'=>$vehicleNumber]);
          $res = $sql->fetch();
          if($res === false) {
            # не нашли
            if($this->msg->db->insert($user,null,$msgCode,$vehicleNumber,time())) return 'INSERT MSG TO DB'; 
            else return 'INSERT ERROR';
          } else {
            # нашли
            $this->msg->go($res['msgid']);
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
