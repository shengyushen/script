awk -F, '{print $1 " " $3 " " $4 " " $5 " " $6}' ssytop500.csv > /tmp/all
grep Infiniband /tmp/all > /tmp/Infiniband
grep Ethernet /tmp/all  > /tmp/Ethernet
grep Omnipath /tmp/all > /tmp/Omnipath
grep Aries /tmp/all > /tmp/Aries
gnuplot -p -e 'set key above; set xlabel "rank in top500";set ylabel "MPI efficiency";fi(x)=ci;fit fi(x) "/tmp/Infiniband" u 1:3 via ci;fo(x)=co;fit fo(x) "/tmp/Omnipath" u 1:3 via co;fe(x)=ce;fit fe(x) "/tmp/Ethernet" u 1:3 via ce;fa(x)=ca;fit fa(x) "/tmp/Aries" u 1:3 via ca; plot "/tmp/Infiniband" u 1:3,fi(x) w lines title "Infiniband Average", "/tmp/Ethernet" u 1:3,fe(x) w line title "Ethernet Average","/tmp/Omnipath" u 1:3, fo(x) w line title "Omnipath Average","/tmp/Aries" u 1:3, fa(x) w line title "Cray Average"'

