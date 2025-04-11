#!/bin/bash
pwd >> /tmp/nohuplog.txt
prcid=$(ps -ef | grep python | grep -v "color" | awk '{print $2}')
echo $prcid >> /tmp/nohuplog.txt
for pid in $prcid; do  echo "Killing $pid" >> /tmp/nohuplog.txt ; kill -9 $pid >> /tmp/nohuplog.txt ; sleep 2; done
sleep 3
ps -ef | grep python >> /tmp/nohuplog.txt
echo dt=$(date +"%Y-%m-%d_%H-%M-%S") >> /tmp/nohuplog.txt
nohup python3 ~/santhosh/invo/app.py prod & >> /tmp/nohuplog.txt
echo "After restarting" >> /tmp/nohuplog.txt
prcid=$(ps -ef | grep python | grep -v "color" | awk '{print $2}')
echo $prcid >> /tmp/nohuplog.tx
dt=$(date +"%Y-%m-%d_%H-%M-%S")
echo $dt > ~/santhosh/invo/lastrun.txt