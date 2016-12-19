<?php
return [function(){
  $db = new PDO('pgsql:host='.self::$conf['host'].';dbname='.self::$conf['base'].'',self::$conf['user'],self::$conf['pass']);
  $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
  return $db;
},'SINGLE']
?>
