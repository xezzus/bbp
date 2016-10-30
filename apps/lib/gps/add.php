<?php
return [function($token,$gps,$used){

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
        # проверяем координаты на формат
        $gps = trim($gps);
        if(preg_match('/^\d{1,2}\.\d{6}\,[\s]*\d{1,2}\.\d{6}$/Uui',$gps)){
          $gps = explode(',',$gps);
          $latitude = $gps[0];
          $longitude = $gps[1];
          # запись
          $db = $this->db->pg();
          $sql = "insert into gps (user_id,latitude,longitude,used,time) values ((select phone_hash from users where token = :token limit 1),:latitude,:longitude,:used,'".time()."') returning true as true;";
          $sql = $db->prepare($sql);
          $sql->execute([':token'=>$token,':latitude'=>$latitude,':longitude'=>$longitude,':used'=>$used]);
          $res = $sql->fetch();
          var_dump($sql->errorInfo());
          if($res === false) return 'INSERT ERROR';
          else {
            if($used == true){
              $sql = "update users set gps = true where token = :token returning true as true";
              $sql = $db->prepare($sql);
              $sql->execute([':token'=>$token]);
              $res = $sql->fetch();
              if($res === false) return 'UPDATE ERROR';
              else return 'SUCCESS';
            } else {
              return 'USED FALSE';
            }
          }
        } else {
          return ['GPS MALFORMED'];
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
