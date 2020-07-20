cat shuffle.log |grep -v "^std\|driver"|awk '{print $23 " " $24 " " $25 " " $26}' > s2
gnuplot -p -e 'set term pngcairo;set output "shuffle..png";set ylabel "MB";set xlabel "Executors";plot "s2" u 0:($1*1000) w linesp title "shuffle read", "" u 0:3 w linesp title "shuffle write"'

