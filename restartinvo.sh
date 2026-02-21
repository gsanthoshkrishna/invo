#!/bin/bash
app_home=$1
app_env=$2
prcid=$(ps -ef | grep python | grep -v "color" | awk '{print $2}')
echo $prcid 
for pid in $prcid; do  echo "Killing $pid" ; kill -9 $pid  ; sleep 2; done
sleep 3
ps -ef | grep python 
echo dt=$(date +"%Y-%m-%d_%H-%M-%S") 
nohup python3 ~/invo/app.py prod "/home/invo/invo" >> /tmp/applog.log 2>&1 & 
echo "After restarting" 
prcid=$(ps -ef | grep python | grep -v "color" | awk '{print $2}')
echo $prcid 

