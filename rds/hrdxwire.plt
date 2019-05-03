#!/usr/bin/gnuplot -p
wiren(n,w) = n*n*w
#set logscale xy
set xlabel "Port number"
set ylabel "Wire number"
plot [1:36] \
		wiren(x,40) title "2005,3.125Gbps*4lane,width=40",\
		wiren(x,256) title "2009,10Gbps*8lane,width=256",\
		wiren(x,320) title "2012,14Gbps*8lane,width=320",\
		wiren(x,256) title "2015,25Gbps*4lane,width=256"

