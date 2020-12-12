set title "Location data"
set xlabel "location"
set ylabel "count"
set grid
set term png
set output 'out.png'
plot 'tcp_velVsOthers.txt' u (column(1)):5 with linespoints ls 1 title""

