#!/bin/sh
for i in $(seq 1 19); do 
	git pull origin master
	if [ -f upgradePg ]; then
		psql -d bbp -U bbp -w < clean.sql
		psql -d bbp -U bbp -w < dump.sql
		rm upgradePg
	fi
  git add -A
  git commit -m "Deploy"
  git push origin master
	sleep 3;
done



