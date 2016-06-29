<?php
return [function($token,$size,$page=1){
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
        $page = ($page < 1) ? 1 : $page ;
        $offset = ($page-1)*$size;
        $db = $this->db->pg();
        $sql = "select phone_hash as id from users order by rating desc offset $offset limit $size";
        $sql = $db->prepare($sql);
        $sql->execute();
        $res = $sql->fetchAll();
        return $res;
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
