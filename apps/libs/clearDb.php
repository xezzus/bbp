<?php
return [function(){
  $db = $this->db->pg();
  $sql = "TRUNCATE users,devices,requests,bans,msg,vehicle,gps RESTART IDENTITY;";
  $db->exec($sql);
  return "SUCCESS";
},'PUBLIC'];
?>
