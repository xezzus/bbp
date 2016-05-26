<?php
return function(){
  self::$once = true;
  $db = new PDO('pgsql:host='.self::$conf['host'].';dbname='.self::$conf['base'].'',self::$conf['user'],self::$conf['pass'],[PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8']);
  $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
  return $db;
}
?>
