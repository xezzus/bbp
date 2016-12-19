<?php
return function($msg){
  openlog("bbp", LOG_PERROR, LOG_LOCAL0);
  syslog(LOG_WARNING, $msg);
  closelog();
}
?>
