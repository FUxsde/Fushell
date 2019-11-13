#!/bin/bash

datetime=$(date -d "-1 day" "+%Y%m%d")
log="/usr/local/nginx/logs"
pid="/usr/local/nginx/logs/nginx.pid"
[ -d $log/bak ] || mkdir $log/bak
if [ -f $pid ]
then 
	mv $log/access.log $log/bak/access.log-$datetime
	kill -USR1 $(cat $pid)
	find $log/bak -mtime +30 | xargs rm -rf 
else
	echo "错误，nginx未运行" | tee -a /var/log/messages
fi
