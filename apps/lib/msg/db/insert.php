<?php
return function($sender,$repicient,$code,$vehicleNumber,$time){
  $db = $this->db->pg();
  $sql = "insert into msg (sender,recipient,code,vehicle_number,time) values (:sender,:repicient,:code,:vehicleNumber,:time) returning true as true";
  $sql = $db->prepare($sql);
  if(empty($code)) $code = null;
  $sql->execute([':sender'=>$sender,':repicient'=>$repicient,':code'=>$code,':vehicleNumber'=>$vehicleNumber,':time'=>$time]);
  $res = $sql->fetch();
  if($res === false) return false;
  else return true;
}
?>
