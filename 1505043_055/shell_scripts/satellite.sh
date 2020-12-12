#INPUT: output file AND number of iterations
output_file_format="sat";
iteration_float=1.0;

start=4
end=20


iteration=$(printf %.0f $iteration_float);

r=$start
rm -rf "sat_test"
mkdir "sat_test"
rm -rf "graphs_sat"
mkdir "graphs_sat"
mkdir "sat_test/varying_longitude"
mkdir "sat_test/graph_files"

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
long=$(($r*5))

mkdir "sat_test/varying_longitude/$long"

dir="sat_test/varying_longitude/$long/"

dirgraph="sat_test/graph_files/"

under="_"
others="Others"
vs="Vs"
all="all"
node="node"
range="coverage_area"

longitude="longitude"
pckt="pack"
grInf="graph-data"
avrg="avg"


output_file_fl="$dir$output_file_format$under$longitude$under$long$under$all.out"
############  VARIATION IN longitude COUNT STARTS HERE #####################

l2=0;thr2=0.0;del2=0.0;s_packet2=0.0;r_packet2=0.0;d_packet2=0.0;del_ratio2=0.0;
dr_ratio2=0.0;time2=0.0;t_energy2=0.0;energy_bit2=0.0;energy_byte2=0.0;energy_packet2=0.0;total_retransmit2=0.0;

while [ $j -lt $iteration ]
do
#################START AN ITERATION
echo "                             EXECUTING $(($j+1)) th ITERATION"
echo " 	                      longitude is set to $(($long)) "


ns satellite.tcl $long 
echo "SIMULATION COMPLETE. BUILDING STAT......"
#awk -f rule_th_del_enr_tcp.awk 802_11_grid_tcp_with_energy_random_traffic.tr > math_model1.out
awk -f extract_satellite_data.awk out.tr > satellite_data.out

while read val
do
#	l=$(($l+$inc))
	l2=$(($l2+1))

#	echo -ne "Throughput:          $thr " > $output_file

	if [ "$l2" == "1" ]; then
		thr2=$(echo "scale=5; $thr2+$val/$iteration_float" | bc)
		echo -ne "throughput: $val \n " >> $output_file_fl
	elif [ "$l2" == "2" ]; then
		del2=$(echo "scale=5; $del2+$val/$iteration_float" | bc)
		echo -ne "delay: $val \n" >> $output_file_fl
	elif [ "$l2" == "3" ]; then
		s_packet2=$(echo "scale=5; $s_packet2+$val/$iteration_float" | bc)
		echo -ne "send packet: $val \n " >> $output_file_fl
	elif [ "$l2" == "4" ]; then
		r_packet2=$(echo "scale=5; $r_packet2+$val/$iteration_float" | bc)
		echo -ne "received packet: $val \n " >> $output_file_fl
	elif [ "$l2" == "5" ]; then
		d_packet2=$(echo "scale=5; $d_packet2+$val/$iteration_float" | bc)
		echo -ne "drop packet: $val \n" >> $output_file_fl
	elif [ "$l2" == "6" ]; then
		del_ratio2=$(echo "scale=5; $del_ratio2+$val/$iteration_float" | bc)
		echo -ne "delivery ratio: $val \n" >> $output_file_fl
	elif [ "$l2" == "7" ]; then
		dr_ratio2=$(echo "scale=5; $dr_ratio2+$val/$iteration_float" | bc)
		echo -ne "drop ratio: $val \n " >> $output_file_fl
	elif [ "$l2" == "8" ]; then
		time2=$(echo "scale=5; $time2+$val/$iteration_float" | bc)
		echo -ne "time: $val \n" >> $output_file_fl
	elif [ "$l2" == "9" ]; then 
		t_energy2=$(echo "scale=5; $t_energy2+$val/$iteration_float" | bc)
		echo -ne "total_energy: $val \n" >> $output_file_fl
	elif [ "$l2" == "10" ]; then
		energy_bit2=$(echo "scale=5; $energy_bit2+$val/$iteration_float" | bc)
		echo -ne "energy_per_bit: $val \n" >> $output_file_fl
	elif [ "$l2" == "11" ]; then
		energy_byte2=$(echo "scale=5; $energy_byte2+$val/$iteration_float" | bc)
		echo -ne "energy_per_byte: $val \n" >> $output_file_fl
	elif [ "$l2" == "12" ]; then
		energy_packet2=$(echo "scale=5; $energy_packet2+$val/$iteration_float" | bc)
		echo -ne "energy_per_packet: $val \n" >> $output_file_fl
	elif [ "$l2" == "13" ]; then
		total_retransmit2=$(echo "scale=5; $total_retransmit2+$val/$iteration_float" | bc)
		echo -ne "total_retrnsmit: $val \n\n" >> $output_file_fl
	fi


	echo "$val"
done < satellite_data.out

j=$(($j+1))
l2=0
#################END AN ITERATION
done

output_file2_fl="$dir$output_file_format$under$longitude$under$long$under$avrg.out"
output_file2_grph2="$dirgraph$output_file_format$under$longitude$vs$others.txt"

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

echo -ne "$long\t$del2 \n" >> $output_file2_grph2

############  VARIATION IN longitude COUNT ENDS HERE #####################




r=$(($r+4))
#######################################END A ROUND
done
gnuplot -p satellite.plt
