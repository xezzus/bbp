<?php
return function($var1,$var2){
  self::$http = true;
  return ['var1'=>$var1,'var2'=>$var2];
}
?>
