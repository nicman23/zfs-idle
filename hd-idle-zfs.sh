#!/bin/zsh
pool=zdata

devices=$(zpool status -P $pool | grep /dev/ | awk '{print $1}' | grep -v nvme)
intervalinsec=300

while true; do
  zpool iostat -HyL zdata $intervalinsec 1 |
   grep -q '0	0	0	0' ; res=$?

  if [ $res -eq 0 ]; then
    for i in `echo $devices`; do
      hdparm -Y $i
    done
    while ( smartctl -i -n standby ${devices[0]} | grep -q 'Device is in STANDBY' ); sleep 1m
  fi
done
