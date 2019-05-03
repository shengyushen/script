#!/bin/bash
gunzip --keep -c /var/log/syslog*.gz  > xxx
grep "Starting NVIDIA" xxx | awk '{print $1 "-" $2 "-" $3 " " 1 }' > xx
gnuplot -p -e 'set xdata time;set timefmt "%b-%d-%H:%M:%S"; plot "xx" u 1:2'

