#!/bin/sh
for i in $(seq 1 3); do 
	git pull origin master
	if [ -f upgradePg ]; then
		psql -d bbp -U bbp -w < clean.sql
		psql -d bbp -U bbp -w < dump.sql
		rm upgradePg
	fi
	sleep 3;
done



