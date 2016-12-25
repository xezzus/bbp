#!/bin/sh

cd /home/web/bbp-dev.xezzus.ru
/usr/bin/git add -A
DATE=`date +%d-%m-%Y' '%H:%M:%S`
/usr/bin/git commit -m "$DATE"
/usr/bin/git push origin master
