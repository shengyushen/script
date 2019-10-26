awk -F, '{print $1 " " $3 " " $4 " " $5}' ssytop500.csv > all
grep Infiniband all > Infiniband
grep Ethernet all  > Ethernet
grep Omnipath all > Omnipath
gnuplot -p -e 'set key above; set xlabel "rank in top501";set ylabel "MPI efficiency";fi(x)=ci;fit fi(x) "Infiniband" u 1:3 via ci;fo(x)=co;fit fo(x) "Omnipath" u 1:3 via co;fe(x)=ce;fit fe(x) "Ethernet" u 1:3 via ce; plot "Infiniband" u 1:3,fi(x) w lines title "Infiniband Average", "Ethernet" u 1:3,fe(x) w line title "Ethernet Average","Omnipath" u 1:3, fo(x) w line title "Omnipath Average"'

