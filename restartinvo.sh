#!/bin/bash
prcid=$(ps -ef | grep python | grep -v "color" | awk '{print $2}')
echo $prcid
for pid in $prcid; do  echo $pid; kill -9 $pid; sleep 2; done
sleep 3
ps -ef | grep python
nohup python3 ~/santhosh/invo/app.py & > /dev/null &
echo "After restarting"
prcid=$(ps -ef | grep python | grep -v "color" | awk '{print $2}')
echo $prcid
dt=$(date +"%Y-%m-%d_%H-%M-%S")
echo $dt > ~/santhosh/invo/lastrun.txt
