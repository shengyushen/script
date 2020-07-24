gnuplot -p -e 'set term pngcairo;set output "percent.png";set ylabel "%";set xlabel " ";plot "all" u ($2*100):xtic(1) w linesp title "HaplotypeCaller", "" u ($3*100):xtic(1) w linesp title "BQSR"'
