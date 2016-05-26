<?php
return function($data){
  return crypt($data,$this->salt());
}
?>
