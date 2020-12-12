set title "Throughput vs Node\n{/*0.7 flow:20  packets/sec:200  velocity:5}"
set xlabel "node"
set ylabel "throughput"
set grid
set term png
set output 'graphs_11new_mob/thr_vs_node.png'
plot '802_11new_mobile_test/graph_files/tcp_nodeVsOthers.txt' u (column(1)):2 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_nodeVsOthers.txt' u (column(1)):2 with linespoints ls 1 lc rgb '#09ad00' title"original"

set title "Throughput vs Velocity\n{/*0.7 nodes:70  flow:20  packets/sec:200}"
set xlabel "velocity"
set ylabel "throughput"
set grid
set term png
set output 'graphs_11new_mob/thr_vs_velocity.png'
plot '802_11new_mobile_test/graph_files/tcp_velVsOthers.txt' u (column(1)):2 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_velVsOthers.txt' u (column(1)):2 with linespoints ls 1 lc rgb '#09ad00' title"original"

set title "Throughput vs Flow\n{/*0.7 nodes:70  packets/sec:200 velocity:5}"
set xlabel "flow"
set ylabel "throughput"
set grid
set term png
set output 'graphs_11new_mob/thr_vs_flow.png'
plot '802_11new_mobile_test/graph_files/tcp_flowVsOthers.txt' u (column(1)):2 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_flowVsOthers.txt' u (column(1)):2 with linespoints ls 1 lc rgb '#09ad00' title"original"

set title "Throughput vs Packets\n{/*0.7 nodes:70  flow:20  velocity:5}"
set xlabel "packets/sec"
set ylabel "throughput"
set grid
set term png
set output 'graphs_11new_mob/thr_vs_packet.png'
plot '802_11new_mobile_test/graph_files/tcp_packVsOthers.txt' u (column(1)):2 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_packVsOthers.txt' u (column(1)):2 with linespoints ls 1 lc rgb '#09ad00' title"original"




set title "Delay vs Node\n{/*0.7 flow:20  packets/sec:200  velocity:5}"
set xlabel "node"
set ylabel "Delay"
set grid
set term png
set output 'graphs_11new_mob/delay_vs_node.png'
plot '802_11new_mobile_test/graph_files/tcp_nodeVsOthers.txt' u (column(1)):3 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_nodeVsOthers.txt' u (column(1)):3 with linespoints ls 1 lc rgb '#09ad00' title"original"

set title "Delay vs Velocity\n{/*0.7 nodes:70  flow:20  packets/sec:200}"
set xlabel "velocity"
set ylabel "delay"
set grid
set term png
set output 'graphs_11new_mob/delay_vs_velc.png'
plot '802_11new_mobile_test/graph_files/tcp_velVsOthers.txt' u (column(1)):3 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_velVsOthers.txt' u (column(1)):3 with linespoints ls 1 lc rgb '#09ad00' title"original"

set title "Delay vs Flow\n{/*0.7 nodes:70  packets/sec:200  velocity:5}"
set xlabel "flow"
set ylabel "delay"
set grid
set term png
set output 'graphs_11new_mob/delay_vs_flow.png'
plot '802_11new_mobile_test/graph_files/tcp_flowVsOthers.txt' u (column(1)):3 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_flowVsOthers.txt' u (column(1)):3 with linespoints ls 1 lc rgb '#09ad00' title"original"

set title "Delay vs Packets\n{/*0.7 nodes:70  flow:20  velocity:5}"
set xlabel "packets/sec"
set ylabel "delay"
set grid
set term png
set output 'graphs_11new_mob/delay_vs_packet.png'
plot '802_11new_mobile_test/graph_files/tcp_packVsOthers.txt' u (column(1)):3 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_packVsOthers.txt' u (column(1)):3 with linespoints ls 1 lc rgb '#09ad00' title"original"




set title "Delivery-Ratio vs Node\n{/*0.7  flow:20  packets/sec:200 velocity 5}"
set xlabel "node"
set ylabel "Delivery-Ratio"
set grid
set term png
set output 'graphs_11new_mob/delRatio_vs_node.png'
plot '802_11new_mobile_test/graph_files/tcp_nodeVsOthers.txt' u (column(1)):4 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_nodeVsOthers.txt' u (column(1)):4 with linespoints ls 1 lc rgb '#09ad00' title"original"

set title "Delivery-Ratio vs Velocity\n{/*0.7 nodes:70  flow:20  packets/sec:200}"
set xlabel "velocity"
set ylabel "Delivery-Ratio"
set grid
set term png
set output 'graphs_11new_mob/delRatio_vs_velc.png'
plot '802_11new_mobile_test/graph_files/tcp_velVsOthers.txt' u (column(1)):4 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_velVsOthers.txt' u (column(1)):4 with linespoints ls 1 lc rgb '#09ad00' title"original"

set title "Delivery-Ratio vs Flow\n{/*0.7 nodes:70  packets/sec:200  velocity:5}"
set xlabel "flow"
set ylabel "Delivery-Ratio"
set grid
set term png
set output 'graphs_11new_mob/delRatio_vs_flow.png'
plot '802_11new_mobile_test/graph_files/tcp_flowVsOthers.txt' u (column(1)):4 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_flowVsOthers.txt' u (column(1)):4 with linespoints ls 1 lc rgb '#09ad00' title"original"

set title "Delivery-Ratio vs Packets\n{/*0.7 nodes:70  flow:20  velocity:5}"
set xlabel "packets/sec"
set ylabel "Delivery-Ratio"
set grid
set term png
set output 'graphs_11new_mob/delRatio_vs_packet.png'
plot '802_11new_mobile_test/graph_files/tcp_packVsOthers.txt' u (column(1)):4 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_packVsOthers.txt' u (column(1)):4 with linespoints ls 1 lc rgb '#09ad00' title"original"




set title "Drop-Ratio vs Node\n{/*0.7 flow:20  packets/sec:200  velocity:5}"
set xlabel "node"
set ylabel "Drop-Ratio"
set grid
set term png
set output 'graphs_11new_mob/dropRatio_vs_node.png'
plot '802_11new_mobile_test/graph_files/tcp_nodeVsOthers.txt' u (column(1)):5 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_nodeVsOthers.txt' u (column(1)):5 with linespoints ls 1 lc rgb '#09ad00' title"original"

set title "Drop-Ratio vs Velocity\n{/*0.7 nodes:70  flow:20  packets/sec:200}"
set xlabel "velocity"
set ylabel "Drop-Ratio"
set grid
set term png
set output 'graphs_11new_mob/dropRatio_vs_velc.png'
plot '802_11new_mobile_test/graph_files/tcp_velVsOthers.txt' u (column(1)):5 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_velVsOthers.txt' u (column(1)):5 with linespoints ls 1 lc rgb '#09ad00' title"original"

set title "Drop-Ratio vs Flow\n{/*0.7 nodes:70  packets/sec:200  velocity:5}"
set xlabel "flow"
set ylabel "Drop-Ratio"
set grid
set term png
set output 'graphs_11new_mob/dropRatio_vs_flow.png'
plot '802_11new_mobile_test/graph_files/tcp_flowVsOthers.txt' u (column(1)):5 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_flowVsOthers.txt' u (column(1)):5 with linespoints ls 1 lc rgb '#09ad00' title"original"

set title "Drop-Ratio vs Packets\n{/*0.7 nodes:70  flow:20  velocity:5}"
set xlabel "packets/sec"
set ylabel "Drop-Ratio"
set grid
set term png
set output 'graphs_11new_mob/dropRatio_vs_packet.png'
plot '802_11new_mobile_test/graph_files/tcp_packVsOthers.txt' u (column(1)):5 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_packVsOthers.txt' u (column(1)):5 with linespoints ls 1 lc rgb '#09ad00' title"original"




set title "Energy vs Node\n{/*0.7 flow:20  packets/sec:200  velocity:5}"
set xlabel "node"
set ylabel "Energy"
set grid
set term png
set output 'graphs_11new_mob/energy_vs_node.png'
plot '802_11new_mobile_test/graph_files/tcp_nodeVsOthers.txt' u (column(1)):6 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_nodeVsOthers.txt' u (column(1)):6 with linespoints ls 1 lc rgb '#09ad00' title"original"

set title "Energy vs Velocity\n{/*0.7 nodes:70  flow:20  packets/sec:200}"
set xlabel "velocity"
set ylabel "Energy"
set grid
set term png
set output 'graphs_11new_mob/energy_vs_velc.png'
plot '802_11new_mobile_test/graph_files/tcp_velVsOthers.txt' u (column(1)):6 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_velVsOthers.txt' u (column(1)):6 with linespoints ls 1 lc rgb '#09ad00' title"original"

set title "Energy vs Flow\n{/*0.7 nodes:70  packets/sec:200  velocity:5}"
set xlabel "flow"
set ylabel "Energy"
set grid
set term png
set output 'graphs_11new_mob/energy_vs_flow.png'
plot '802_11new_mobile_test/graph_files/tcp_flowVsOthers.txt' u (column(1)):6 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_flowVsOthers.txt' u (column(1)):6 with linespoints ls 1 lc rgb '#09ad00' title"original"

set title "Energy vs Packets\n{/*0.7 nodes:70  flow:20  velocity:5}"
set xlabel "packets/sec"
set ylabel "Energy"
set grid
set term png
set output 'graphs_11new_mob/energy_vs_packet.png'
plot '802_11new_mobile_test/graph_files/tcp_packVsOthers.txt' u (column(1)):6 with linespoints ls 1 title"modified",'802_11_test/graph_files/tcp_packVsOthers.txt' u (column(1)):6 with linespoints ls 1 lc rgb '#09ad00' title"original"
