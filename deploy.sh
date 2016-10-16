#!/bin/sh
export PGPASSWORD=1234567890
export PGHOST=localhost
export PGDATABASE=api
export PGUSER=api
for i in $(seq 1 19); do 
	git pull origin master
	if [ -f upgradePg ]; then
		psql -d api -U api -w < clean.sql
		psql -d api -U api -w < dump.sql
		rm upgradePg
	fi
  git add -A
  git commit -m "Deploy"
  git push origin master
	sleep 3;
done



