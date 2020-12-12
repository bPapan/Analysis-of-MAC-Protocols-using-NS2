set title "Throughput vs Node\n{/*0.7 flow:20  packets/sec:200  coverage area:100 X 175}"
set xlabel "node"
set ylabel "throughput"
set grid
set term png
set output 'graphs_15/thr_vs_node.png'
plot '802_15_test/graph_files/tcp_nodeVsOthers.txt' u (column(1)):2 with linespoints ls 1 title""

set title "Throughput vs Coverage-area\n{/*0.7 nodes:70  flow:20  packets/sec:200}"
set xlabel "coverage-area"
set ylabel "throughput"
set grid
set term png
set output 'graphs_15/thr_vs_coverage_area.png'
plot '802_15_test/graph_files/tcp_coverage_areaVsOthers.txt' u (column(1)):2 with linespoints ls 1 title""

set title "Throughput vs Flow\n{/*0.7 nodes:70  packets/sec:200 coverage area:100 X 175}"
set xlabel "flow"
set ylabel "throughput"
set grid
set term png
set output 'graphs_15/thr_vs_flow.png'
plot '802_15_test/graph_files/tcp_flowVsOthers.txt' u (column(1)):2 with linespoints ls 1 title""

set title "Throughput vs Packets\n{/*0.7 nodes:70  flow:20  coverage area:100 X 175}"
set xlabel "packets/sec"
set ylabel "throughput"
set grid
set term png
set output 'graphs_15/thr_vs_packet.png'
plot '802_15_test/graph_files/tcp_packVsOthers.txt' u (column(1)):2 with linespoints ls 1 title""




set title "Delay vs Node\n{/*0.7 flow:20  packets/sec:200  coverage area:100 X 175}"
set xlabel "node"
set ylabel "Delay"
set grid
set term png
set output 'graphs_15/delay_vs_node.png'
plot '802_15_test/graph_files/tcp_nodeVsOthers.txt' u (column(1)):3 with linespoints ls 1 title""

set title "Delay vs Coverage-area\n{/*0.7 nodes:70  flow:20  packets/sec:200}"
set xlabel "coverage-area"
set ylabel "delay"
set grid
set term png
set output 'graphs_15/delay_vs_coverage_area.png'
plot '802_15_test/graph_files/tcp_coverage_areaVsOthers.txt' u (column(1)):3 with linespoints ls 1 title""

set title "Delay vs Flow\n{/*0.7 nodes:70  packets/sec:200 coverage area:100 X 175}"
set xlabel "flow"
set ylabel "delay"
set grid
set term png
set output 'graphs_15/delay_vs_flow.png'
plot '802_15_test/graph_files/tcp_flowVsOthers.txt' u (column(1)):3 with linespoints ls 1 title""

set title "Delay vs Packets\n{/*0.7 nodes:70  flow:20  coverage area:100 X 175}"
set xlabel "packets/sec"
set ylabel "delay"
set grid
set term png
set output 'graphs_15/delay_vs_packet.png'
plot '802_15_test/graph_files/tcp_packVsOthers.txt' u (column(1)):3 with linespoints ls 1 title""




set title "Delivery-Ratio vs Node\n{/*0.7 flow:20  packets/sec:200  coverage area:100 X 175}"
set xlabel "node"
set ylabel "Delivery-Ratio"
set grid
set term png
set output 'graphs_15/delRatio_vs_node.png'
plot '802_15_test/graph_files/tcp_nodeVsOthers.txt' u (column(1)):4 with linespoints ls 1 title""

set title "Delivery-Ratio vs Coverage-area\n{/*0.7 nodes:70  flow:20  packets/sec:200}"
set xlabel "coverage-area"
set ylabel "Delivery-Ratio"
set grid
set term png
set output 'graphs_15/delRatio_vs_coverage_area.png'
plot '802_15_test/graph_files/tcp_coverage_areaVsOthers.txt' u (column(1)):4 with linespoints ls 1 title""

set title "Delivery-Ratio vs Flow\n{/*0.7 nodes:70  packets/sec:200 coverage area:100 X 175}"
set xlabel "flow"
set ylabel "Delivery-Ratio"
set grid
set term png
set output 'graphs_15/delRatio_vs_flow.png'
plot '802_15_test/graph_files/tcp_flowVsOthers.txt' u (column(1)):4 with linespoints ls 1 title""

set title "Delivery-Ratio vs Packets\n{/*0.7 nodes:70  flow:20  coverage area:100 X 175}"
set xlabel "packet"
set ylabel "Delivery-Ratio"
set grid
set term png
set output 'graphs_15/delRatio_vs_packet.png'
plot '802_15_test/graph_files/tcp_packVsOthers.txt' u (column(1)):4 with linespoints ls 1 title""




set title "Drop-Ratio vs Node\n{/*0.7 flow:20  packets/sec:200  coverage area:100 X 175}"
set xlabel "node"
set ylabel "Drop-Ratio"
set grid
set term png
set output 'graphs_15/dropRatio_vs_node.png'
plot '802_15_test/graph_files/tcp_nodeVsOthers.txt' u (column(1)):5 with linespoints ls 1 title""

set title "Drop-Ratio vs Coverage-area\n{/*0.7 nodes:70  flow:20  packets/sec:200}"
set xlabel "coverage-area"
set ylabel "Drop-Ratio"
set grid
set term png
set output 'graphs_15/dropRatio_vs_coverage_area.png'
plot '802_15_test/graph_files/tcp_coverage_areaVsOthers.txt' u (column(1)):5 with linespoints ls 1 title""

set title "Drop-Ratio vs Flow\n{/*0.7 nodes:70  packets/sec:200 coverage area:100 X 175}"
set xlabel "flow"
set ylabel "Drop-Ratio"
set grid
set term png
set output 'graphs_15/dropRatio_vs_flow.png'
plot '802_15_test/graph_files/tcp_flowVsOthers.txt' u (column(1)):5 with linespoints ls 1 title""

set title "Drop-Ratio vs Packets\n{/*0.7 nodes:70  flow:20  coverage area:100 X 175}"
set xlabel "packet"
set ylabel "Drop-Ratio"
set grid
set term png
set output 'graphs_15/dropRatio_vs_packet.png'
plot '802_15_test/graph_files/tcp_packVsOthers.txt' u (column(1)):5 with linespoints ls 1 title""




set title "Energy vs Node\n{/*0.7 flow:20  packets/sec:200  coverage area:100 X 175}"
set xlabel "node"
set ylabel "Energy"
set grid
set term png
set output 'graphs_15/energy_vs_node.png'
plot '802_15_test/graph_files/tcp_nodeVsOthers.txt' u (column(1)):6 with linespoints ls 1 title""

set title "Energy vs Coverage-area\n{/*0.7 nodes:70  flow:20  packets/sec:200}"
set xlabel "coverage-area"
set ylabel "Energy"
set grid
set term png
set output 'graphs_15/energy_vs_coverage_area.png'
plot '802_15_test/graph_files/tcp_coverage_areaVsOthers.txt' u (column(1)):6 with linespoints ls 1 title""

set title "Energy vs Flow\n{/*0.7 nodes:70  packets/sec:200 coverage area:100 X 175}"
set xlabel "flow"
set ylabel "Energy"
set grid
set term png
set output 'graphs_15/energy_vs_flow.png'
plot '802_15_test/graph_files/tcp_flowVsOthers.txt' u (column(1)):6 with linespoints ls 1 title""

set title "Energy vs Packets\n{/*0.7 nodes:70  flow:20  coverage area:100 X 175}"
set xlabel "packets/sec"
set ylabel "Energy"
set grid
set term png
set output 'graphs_15/energy_vs_packet.png'
plot '802_15_test/graph_files/tcp_packVsOthers.txt' u (column(1)):6 with linespoints ls 1 title""
