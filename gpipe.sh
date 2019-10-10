cat lmgpipe |grep HtoD |awk -F,  '{print $1 " " $12 " " substr($16,24,length($16)-25)}' > htod
cat lmgpipe |grep DtoH |awk -F,  '{print $1 " " $12 " " substr($16,24,length($16)-25)}' > dtoh
cat lmgpipe |grep PtoP|awk -F, '{print $1 " " $12 " " substr($16,24,length($16)-25) " " substr($19,24,length($19)-25)}' > ptop
gnuplot -p -e 'set multiplot layout 3,1;set xlabel "time(seconds)";set ylabel "GPU";set title "100 seconds scale" ;plot "htod" u 1:3,"dtoh" u 1:3;set title "10 seconds scale";plot [250:260] "htod" u 1:3,"dtoh" u 1:3;set title "1 seconds scale";plot [250:251] "htod" u 1:3,"dtoh" u 1:3;'

