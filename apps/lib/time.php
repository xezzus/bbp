<?php
return [function($time=null){
  if($time <= 0){
    return date("Y-m-d H:i:s");
  } else {
    return date("Y-m-d H:i:s",$time);
  }
},'PUBLIC'];
?>
