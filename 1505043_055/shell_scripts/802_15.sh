#INPUT: output file AND number of iterations
output_file_format="tcp";
iteration_float=1.0;

start=4
end=20


iteration=$(printf %.0f $iteration_float);

r=$start
rm -rf "802_15_test"
mkdir "802_15_test"
rm -rf "graphs_15"
mkdir "graphs_15"
mkdir "802_15_test/varying_node_numbers"
mkdir "802_15_test/varying_no_of_flows"
mkdir "802_15_test/varying_no_of_packets"
mkdir "802_15_test/varying_coverage_area"
mkdir "802_15_test/graph_files"

while [ $r -le $end ]
do
echo "total iteration: $iteration"
###############################START A ROUND
l=0;thr=0.0;del=0.0;s_packet=0.0;r_packet=0.0;d_packet=0.0;del_ratio=0.0;
dr_ratio=0.0;time=0.0;t_energy=0.0;energy_bit=0.0;energy_byte=0.0;energy_packet=0.0;total_retransmit=0.0;

i=0
j=0
k=0
m=0
ll=$(($r*5))
fl=$(($r*5/2))
pack=$(($r/4))
pck=$(($pack*100))
rangeDim=$(($r/4))
rng=$(($r*50/4))
area=$((rng*175))

mkdir "802_15_test/varying_node_numbers/$ll"
mkdir "802_15_test/varying_no_of_flows/$fl"
mkdir "802_15_test/varying_no_of_packets/$pck"
mkdir "802_15_test/varying_coverage_area/$rng"
dir="802_15_test/varying_node_numbers/$ll/"
dir2="802_15_test/varying_no_of_flows/$fl/"
dir3="802_15_test/varying_no_of_packets/$pck/"
dir4="802_15_test/varying_coverage_area/$rng/"

dirgraph="802_15_test/graph_files/"

under="_"
others="Others"
vs="Vs"
all="all"
node="node"
range="coverage_area"
flow="flow"
pckt="pack"
grInf="graph-data"
avrg="avg"

output_file="$dir$output_file_format$under$node$under$ll$under$all.out"
output_file_fl="$dir2$output_file_format$under$flow$under$fl$under$all.out"
output_file_pck="$dir3$output_file_format$under$pckt$under$pck$under$all.out"
output_file_rng="$dir4$output_file_format$under$range$under$rng$under$all.out"


############  VARIATION IN NODE NUMBER STARTS HERE  ##################

while [ $i -lt $iteration ]
do
#################START AN ITERATION
echo "                             EXECUTING $(($i+1)) th ITERATION"
echo "				   Number of flow is set to 20"
echo "			 No. of Packets sent per second is set to 200"
echo "				Coverage Area is set to 100 X 175"

ns 802_15_4_grid_tcp.tcl $r 20 2 2 
echo "SIMULATION COMPLETE. BUILDING STAT......"
#awk -f rule_th_del_enr_tcp.awk 802_11_grid_tcp_with_energy_random_traffic.tr > math_model1.out
awk -f rule_tcp_wireless.awk 802_15_4_grid_tcp.tr > tcp_wireless1.out

while read val
do
#	l=$(($l+$inc))
	l=$(($l+1))

#	echo -ne "Throughput:          $thr " > $output_file	
	
	if [ "$l" == "1" ]; then
		thr=$(echo "scale=5; $thr+$val/$iteration_float" | bc)
		echo -ne "throughput: $val " >> $output_file
	elif [ "$l" == "2" ]; then
		del=$(echo "scale=5; $del+$val/$iteration_float" | bc)
		echo -ne "delay: $val " >> $output_file
	elif [ "$l" == "3" ]; then
		s_packet=$(echo "scale=5; $s_packet+$val/$iteration_float" | bc)
		echo -ne "send packet: $val " >> $output_file
	elif [ "$l" == "4" ]; then
		r_packet=$(echo "scale=5; $r_packet+$val/$iteration_float" | bc)
		echo -ne "received packet: $val " >> $output_file
	elif [ "$l" == "5" ]; then
		d_packet=$(echo "scale=5; $d_packet+$val/$iteration_float" | bc)
		echo -ne "drop packet: $val \n" >> $output_file
	elif [ "$l" == "6" ]; then
		del_ratio=$(echo "scale=5; $del_ratio+$val/$iteration_float" | bc)
		echo -ne "delivery ratio: $val " >> $output_file
	elif [ "$l" == "7" ]; then
		dr_ratio=$(echo "scale=5; $dr_ratio+$val/$iteration_float" | bc)
		echo -ne "drop ratio: $val " >> $output_file
	elif [ "$l" == "8" ]; then
		time=$(echo "scale=5; $time+$val/$iteration_float" | bc)
		echo -ne "time: $val " >> $output_file
	elif [ "$l" == "9" ]; then
		t_energy=$(echo "scale=5; $t_energy+$val/$iteration_float" | bc)
		echo -ne "total_energy: $val \n" >> $output_file
	elif [ "$l" == "10" ]; then
		energy_bit=$(echo "scale=5; $energy_bit+$val/$iteration_float" | bc)
		echo -ne "energy_per_bit: $val " >> $output_file
	elif [ "$l" == "11" ]; then
		energy_byte=$(echo "scale=5; $energy_byte+$val/$iteration_float" | bc)
		echo -ne "energy_per_byte: $val " >> $output_file
	elif [ "$l" == "12" ]; then
		energy_packet=$(echo "scale=5; $energy_packet+$val/$iteration_float" | bc)
		echo -ne "energy_per_packet: $val " >> $output_file
	elif [ "$l" == "13" ]; then
		total_retransmit=$(echo "scale=5; $total_retransmit+$val/$iteration_float" | bc)
		echo -ne "total_retrnsmit: $val \n\n" >> $output_file
	fi


	echo "$val"
done < tcp_wireless1.out

i=$(($i+1))
l=0
#################END AN ITERATION
done

under="_"
output_file2="$dir$output_file_format$under$node$under$ll$under$avrg.out"
output_file2_grph1="$dirgraph$output_file_format$under$node$vs$others.txt"

echo -ne "Average Throughput:\t\t$thr \n" > $output_file2
echo -ne "Average Delay:\t\t\t$del \n" >> $output_file2
echo -ne "Average Sent Packets:\t\t$s_packet \n" >> $output_file2
echo -ne "Average Received Packets:\t$r_packet \n" >> $output_file2
echo -ne "Average Dropped Packets:\t$d_packet \n" >> $output_file2
echo -ne "Packet Delivery Ratio:\t\t$del_ratio \n" >> $output_file2
echo -ne "Packet Drop Ratio:\t\t$dr_ratio \n" >> $output_file2
echo -ne "Total time:\t\t\t$time \n" >> $output_file2
echo -ne "Total energy consumption:\t$t_energy \n" >> $output_file2
echo -ne "Average Energy per bit:\t\t$energy_bit \n" >> $output_file2
echo -ne "Average Energy per byte:\t$energy_byte \n" >> $output_file2
echo -ne "Average energy per packet:\t$energy_packet \n" >> $output_file2
echo "total_retransmit:		$total_retransmit" >> $output_file2

echo -ne ""

echo -ne "$ll\t$thr\t$del\t$del_ratio\t$dr_ratio\t$t_energy \n" >> $output_file2_grph1

############  VARIATION IN NODE NUMBER ENDS HERE #####################



############  VARIATION IN FLOW COUNT STARTS HERE #####################

l2=0;thr2=0.0;del2=0.0;s_packet2=0.0;r_packet2=0.0;d_packet2=0.0;del_ratio2=0.0;
dr_ratio2=0.0;time2=0.0;t_energy2=0.0;energy_bit2=0.0;energy_byte2=0.0;energy_packet2=0.0;total_retransmit2=0.0;

while [ $j -lt $iteration ]
do
#################START AN ITERATION
echo "                             EXECUTING $(($j+1)) th ITERATION"
echo " 				Number of flow is set to $(($fl)) "
echo "			 No. of Packets sent per second is set to 200"
echo "				Coverage Area is set to 100 X 175"

ns 802_15_4_grid_tcp.tcl 14 $fl 2 2
echo "SIMULATION COMPLETE. BUILDING STAT......"
#awk -f rule_th_del_enr_tcp.awk 802_11_grid_tcp_with_energy_random_traffic.tr > math_model1.out
awk -f rule_tcp_wireless.awk 802_15_4_grid_tcp.tr > tcp_wireless1.out

while read val
do
#	l=$(($l+$inc))
	l2=$(($l2+1))

#	echo -ne "Throughput:          $thr " > $output_file

	if [ "$l2" == "1" ]; then
		thr2=$(echo "scale=5; $thr2+$val/$iteration_float" | bc)
		echo -ne "throughput: $val " >> $output_file_fl
	elif [ "$l2" == "2" ]; then
		del2=$(echo "scale=5; $del2+$val/$iteration_float" | bc)
		echo -ne "delay: $val " >> $output_file_fl
	elif [ "$l2" == "3" ]; then
		s_packet2=$(echo "scale=5; $s_packet2+$val/$iteration_float" | bc)
		echo -ne "send packet: $val " >> $output_file_fl
	elif [ "$l2" == "4" ]; then
		r_packet2=$(echo "scale=5; $r_packet2+$val/$iteration_float" | bc)
		echo -ne "received packet: $val " >> $output_file_fl
	elif [ "$l2" == "5" ]; then
		d_packet2=$(echo "scale=5; $d_packet2+$val/$iteration_float" | bc)
		echo -ne "drop packet: $val \n" >> $output_file_fl
	elif [ "$l2" == "6" ]; then
		del_ratio2=$(echo "scale=5; $del_ratio2+$val/$iteration_float" | bc)
		echo -ne "delivery ratio: $val " >> $output_file_fl
	elif [ "$l2" == "7" ]; then
		dr_ratio2=$(echo "scale=5; $dr_ratio2+$val/$iteration_float" | bc)
		echo -ne "drop ratio: $val " >> $output_file_fl
	elif [ "$l2" == "8" ]; then
		time2=$(echo "scale=5; $time2+$val/$iteration_float" | bc)
		echo -ne "time: $val " >> $output_file_fl
	elif [ "$l2" == "9" ]; then
		t_energy2=$(echo "scale=5; $t_energy2+$val/$iteration_float" | bc)
		echo -ne "total_energy: $val \n" >> $output_file_fl
	elif [ "$l2" == "10" ]; then
		energy_bit2=$(echo "scale=5; $energy_bit2+$val/$iteration_float" | bc)
		echo -ne "energy_per_bit: $val " >> $output_file_fl
	elif [ "$l2" == "11" ]; then
		energy_byte2=$(echo "scale=5; $energy_byte2+$val/$iteration_float" | bc)
		echo -ne "energy_per_byte: $val " >> $output_file_fl
	elif [ "$l2" == "12" ]; then
		energy_packet2=$(echo "scale=5; $energy_packet2+$val/$iteration_float" | bc)
		echo -ne "energy_per_packet: $val " >> $output_file_fl
	elif [ "$l2" == "13" ]; then
		total_retransmit2=$(echo "scale=5; $total_retransmit2+$val/$iteration_float" | bc)
		echo -ne "total_retrnsmit: $val \n\n" >> $output_file_fl
	fi


	echo "$val"
done < tcp_wireless1.out

j=$(($j+1))
l2=0
#################END AN ITERATION
done

output_file2_fl="$dir2$output_file_format$under$flow$under$fl$under$avrg.out"
output_file2_grph2="$dirgraph$output_file_format$under$flow$vs$others.txt"

echo -ne "Average Throughput:\t\t$thr2 \n" > $output_file2_fl
echo -ne "Average Delay:\t\t\t$del2 \n" >> $output_file2_fl
echo -ne "Average Sent Packets:\t\t$s_packet2 \n" >> $output_file2_fl
echo -ne "Average Received Packets:\t$r_packet2 \n" >> $output_file2_fl
echo -ne "Average Dropped Packets:\t$d_packet2 \n" >> $output_file2_fl
echo -ne "Packet Delivery Ratio:\t\t$del_ratio2 \n" >> $output_file2_fl
echo -ne "Packet Drop Ratio:\t\t$dr_ratio2 \n" >> $output_file2_fl
echo -ne "Total time:\t\t\t$time2 \n" >> $output_file2_fl
echo -ne "Total energy consumption:\t$t_energy2 \n" >> $output_file2_fl
echo -ne "Average Energy per bit:\t\t$energy_bit2 \n" >> $output_file2_fl
echo -ne "Average Energy per byte:\t$energy_byte2 \n" >> $output_file2_fl
echo -ne "Average energy per packet:\t$energy_packet2 \n" >> $output_file2_fl
echo "total_retransmit:		$total_retransmit2" >> $output_file2_fl

echo -ne "$fl\t$thr2\t$del2\t$del_ratio2\t$dr_ratio2\t$t_energy2 \n" >> $output_file2_grph2

############  VARIATION IN FLOW COUNT ENDS HERE #####################




############  VARIATION IN NO. OF PACKET STARTS HERE ##################

l3=0;thr3=0.0;del3=0.0;s_packet3=0.0;r_packet3=0.0;d_packet3=0.0;del_ratio3=0.0;
dr_ratio3=0.0;time3=0.0;t_energy3=0.0;energy_bit3=0.0;energy_byte3=0.0;energy_packet3=0.0;total_retransmit3=0.0;

while [ $k -lt $iteration ]
do
#################START AN ITERATION
echo "                             EXECUTING $(($k+1)) th ITERATION"
echo " 				Number of flow is set to 20 "
echo "			No. of Packets sent per second is set to $(($pck))"
echo "				Coverage Area is set to 100 X 175"

ns 802_15_4_grid_tcp.tcl 14 20 $pack 2
echo "SIMULATION COMPLETE. BUILDING STAT......"
#awk -f rule_th_del_enr_tcp.awk 802_11_grid_tcp_with_energy_random_traffic.tr > math_model1.out
awk -f rule_tcp_wireless.awk 802_15_4_grid_tcp.tr > tcp_wireless1.out

while read val
do
#	l=$(($l+$inc))
	l3=$(($l3+1))

#	echo -ne "Throughput:          $thr " > $output_file

	if [ "$l3" == "1" ]; then
		thr3=$(echo "scale=5; $thr3+$val/$iteration_float" | bc)
		echo -ne "throughput: $val " >> $output_file_pck
	elif [ "$l3" == "2" ]; then
		del3=$(echo "scale=5; $del3+$val/$iteration_float" | bc)
		echo -ne "delay: $val " >> $output_file_pck
	elif [ "$l3" == "3" ]; then
		s_packet3=$(echo "scale=5; $s_packet3+$val/$iteration_float" | bc)
		echo -ne "send packet: $val " >> $output_file_pck
	elif [ "$l3" == "4" ]; then
		r_packet3=$(echo "scale=5; $r_packet3+$val/$iteration_float" | bc)
		echo -ne "received packet: $val " >> $output_file_pck
	elif [ "$l3" == "5" ]; then
		d_packet3=$(echo "scale=5; $d_packet3+$val/$iteration_float" | bc)
		echo -ne "drop packet: $val \n" >> $output_file_pck
	elif [ "$l3" == "6" ]; then
		del_ratio3=$(echo "scale=5; $del_ratio3+$val/$iteration_float" | bc)
		echo -ne "delivery ratio: $val " >> $output_file_pck
	elif [ "$l3" == "7" ]; then
		dr_ratio3=$(echo "scale=5; $dr_ratio3+$val/$iteration_float" | bc)
		echo -ne "drop ratio: $val " >> $output_file_pck
	elif [ "$l3" == "8" ]; then
		time3=$(echo "scale=5; $time3+$val/$iteration_float" | bc)
		echo -ne "time: $val " >> $output_file_pck
	elif [ "$l3" == "9" ]; then
		t_energy3=$(echo "scale=5; $t_energy3+$val/$iteration_float" | bc)
		echo -ne "total_energy: $val \n" >> $output_file_pck
	elif [ "$l3" == "10" ]; then
		energy_bit3=$(echo "scale=5; $energy_bit3+$val/$iteration_float" | bc)
		echo -ne "energy_per_bit: $val " >> $output_file_pck
	elif [ "$l3" == "11" ]; then
		energy_byte3=$(echo "scale=5; $energy_byte3+$val/$iteration_float" | bc)
		echo -ne "energy_per_byte: $val " >> $output_file_pck
	elif [ "$l3" == "12" ]; then
		energy_packet3=$(echo "scale=5; $energy_packet3+$val/$iteration_float" | bc)
		echo -ne "energy_per_packet: $val " >> $output_file_pck
	elif [ "$l3" == "13" ]; then
		total_retransmit3=$(echo "scale=5; $total_retransmit3+$val/$iteration_float" | bc)
		echo -ne "total_retrnsmit: $val \n\n" >> $output_file_pck
	fi


	echo "$val"
done < tcp_wireless1.out

k=$(($k+1))
l3=0
#################END AN ITERATION
done

output_file2_pck="$dir3$output_file_format$under$pckt$under$pck$under$avrg.out"
output_file2_grph3="$dirgraph$output_file_format$under$pckt$vs$others.txt"

echo -ne "Average Throughput:\t\t$thr3 \n" > $output_file2_pck
echo -ne "Average Delay:\t\t\t$del3 \n" >> $output_file2_pck
echo -ne "Average Sent Packets:\t\t$s_packet3 \n" >> $output_file2_pck
echo -ne "Average Received Packets:\t$r_packet3 \n" >> $output_file2_pck
echo -ne "Average Dropped Packets:\t$d_packet3 \n" >> $output_file2_pck
echo -ne "Packet Delivery Ratio:\t\t$del_ratio3 \n" >> $output_file2_pck
echo -ne "Packet Drop Ratio:\t\t$dr_ratio3 \n" >> $output_file2_pck
echo -ne "Total time:\t\t\t$time3 \n" >> $output_file2_pck
echo -ne "Total energy consumption:\t$t_energy3 \n" >> $output_file2_pck
echo -ne "Average Energy per bit:\t\t$energy_bit3 \n" >> $output_file2_pck
echo -ne "Average Energy per byte:\t$energy_byte3 \n" >> $output_file2_pck
echo -ne "Average energy per packet:\t$energy_packet3 \n" >> $output_file2_pck
echo "total_retransmit:		$total_retransmit3" >> $output_file2_pck

echo -ne "$pck\t$thr3\t$del3\t$del_ratio3\t$dr_ratio3\t$t_energy3 \n" >> $output_file2_grph3

############  VARIATION IN NO. OF PACKETS ENDS HERE ###################





############  VARIATION IN COVERAGE AREA STARTS HERE    ###################

l4=0;thr4=0.0;del4=0.0;s_packet4=0.0;r_packet4=0.0;d_packet4=0.0;del_ratio4=0.0;
dr_ratio4=0.0;time4=0.0;t_energy4=0.0;energy_bit4=0.0;energy_byte4=0.0;energy_packet4=0.0;total_retransmit4=0.0;

while [ $m -lt $iteration ]
do
#################START AN ITERATION
echo "                           EXECUTING $(($m+1)) th ITERATION"
echo " 				 Number of flow is set to 20 "
echo "			No. of Packets sent per second is set to 200"
echo "				Coverage Area is set to $(($rangeDim))" 

ns 802_15_4_grid_tcp.tcl 14 20 2 $rangeDim 
echo "SIMULATION COMPLETE. BUILDING STAT......"
#awk -f rule_th_del_enr_tcp.awk 802_11_grid_tcp_with_energy_random_traffic.tr > math_model1.out
awk -f rule_tcp_wireless.awk 802_15_4_grid_tcp.tr > tcp_wireless1.out

while read val
do
#	l=$(($l+$inc))
	l4=$(($l4+1))

#	echo -ne "Throughput:          $thr " > $output_file

	if [ "$l4" == "1" ]; then
		thr4=$(echo "scale=5; $thr4+$val/$iteration_float" | bc)
		echo -ne "throughput: $val " >> $output_file_rng
	elif [ "$l4" == "2" ]; then
		del4=$(echo "scale=5; $del4+$val/$iteration_float" | bc)
		echo -ne "delay: $val " >> $output_file_rng
	elif [ "$l4" == "3" ]; then
		s_packet4=$(echo "scale=5; $s_packet4+$val/$iteration_float" | bc)
		echo -ne "send packet: $val " >> $output_file_rng
	elif [ "$l4" == "4" ]; then
		r_packet4=$(echo "scale=5; $r_packet4+$val/$iteration_float" | bc)
		echo -ne "received packet: $val " >> $output_file_rng
	elif [ "$l4" == "5" ]; then
		d_packet4=$(echo "scale=5; $d_packet4+$val/$iteration_float" | bc)
		echo -ne "drop packet: $val \n" >> $output_file_rng
	elif [ "$l4" == "6" ]; then
		del_ratio4=$(echo "scale=5; $del_ratio4+$val/$iteration_float" | bc)
		echo -ne "delivery ratio: $val " >> $output_file_rng
	elif [ "$l4" == "7" ]; then
		dr_ratio4=$(echo "scale=5; $dr_ratio4+$val/$iteration_float" | bc)
		echo -ne "drop ratio: $val " >> $output_file_rng
	elif [ "$l4" == "8" ]; then
		time4=$(echo "scale=5; $time4+$val/$iteration_float" | bc)
		echo -ne "time: $val " >> $output_file_rng
	elif [ "$l4" == "9" ]; then
		t_energy4=$(echo "scale=5; $t_energy4+$val/$iteration_float" | bc)
		echo -ne "total_energy: $val \n" >> $output_file_rng
	elif [ "$l4" == "10" ]; then
		energy_bit4=$(echo "scale=5; $energy_bit4+$val/$iteration_float" | bc)
		echo -ne "energy_per_bit: $val " >> $output_file_rng
	elif [ "$l4" == "11" ]; then
		energy_byte4=$(echo "scale=5; $energy_byte4+$val/$iteration_float" | bc)
		echo -ne "energy_per_byte: $val " >> $output_file_rng
	elif [ "$l4" == "12" ]; then
		energy_packet4=$(echo "scale=5; $energy_packet4+$val/$iteration_float" | bc)
		echo -ne "energy_per_packet: $val " >> $output_file_rng
	elif [ "$l4" == "13" ]; then
		total_retransmit4=$(echo "scale=5; $total_retransmit4+$val/$iteration_float" | bc)
		echo -ne "total_retrnsmit: $val \n\n" >> $output_file_rng
	fi


	echo "$val"
done < tcp_wireless1.out

m=$(($m+1))
l4=0
#################END AN ITERATION
done

output_file2_rng="$dir4$output_file_format$under$range$under$rng$under$avrg.out"
output_file2_grph4="$dirgraph$output_file_format$under$range$vs$others.txt"

echo -ne "Average Throughput:\t\t$thr4 \n" > $output_file2_rng
echo -ne "Average Delay:\t\t\t$del4 \n" >> $output_file2_rng
echo -ne "Average Sent Packets:\t\t$s_packet4 \n" >> $output_file2_rng
echo -ne "Average Received Packets:\t$r_packet4 \n" >> $output_file2_rng
echo -ne "Average Dropped Packets:\t$d_packet4 \n" >> $output_file2_rng
echo -ne "Packet Delivery Ratio:\t\t$del_ratio4 \n" >> $output_file2_rng
echo -ne "Packet Drop Ratio:\t\t$dr_ratio4 \n" >> $output_file2_rng
echo -ne "Total time:\t\t\t$time4 \n" >> $output_file2_rng
echo -ne "Total energy consumption:\t$t_energy4 \n" >> $output_file2_rng
echo -ne "Average Energy per bit:\t\t$energy_bit4 \n" >> $output_file2_rng
echo -ne "Average Energy per byte:\t$energy_byte4 \n" >> $output_file2_rng
echo -ne "Average energy per packet:\t$energy_packet4 \n" >> $output_file2_rng
echo "total_retransmit:		$total_retransmit4" >> $output_file2_rng

echo -ne "$area\t$thr4\t$del4\t$del_ratio4\t$dr_ratio4\t$t_energy4 \n" >> $output_file2_grph4

############  VARIATION IN COVERAGE AREA ENDS HERE ###################


r=$(($r+4))

#
#################----------END A ROUND-------------###################
#

done

gnuplot -p 802_15_plot.plt
