BEGIN {
		#setting dummy values
		 
	highest_packet_id = -1 ; 
	lowest_packet_id = 1000000 ;
	startTime = 10000.0 ;
	endTime = 0.0 ; 
	sentPackets = 0 ;
	receivedPackets = 0 ;
	receivedBytes = 0 ;
	droppedPackets = 0 ;
	totalDelay = 0.0 ;
	interval = 1 ;
	tempSum = 0.0 ;
	tempReceivedPackets = 0.0 ;
	tempSentPackets = 0.0 ;
	tempDroppedPackets = 0.0 ;
	clockVal = 0.0 ;
	
	
}
{
	event = $1 ;
	time = $2 ;
	from = $3 ;
	to = $4 ;
	type = $5 ;
	pktsize = $6 ;
	flow_id =$8 ;
	src = $9 ;
	dst = $10 ;
	seq_no = $11 ;
	packet_id = $12 ;

	#extracting node from node.port form
	sub(/..$/, "", dst); 
	sub(/..$/, "", src);
	#printf("Dst:%s,src:%s\n",dst,src) ;

	if( packet_id > highest_packet_id ){
		if(type == "cbr"){
			highest_packet_id = packet_id ;
			start_time[packet_id] = 0 ;
			end_time[packet_id]=-1 ;
		}else{
			#non cbr packet
			start_time[packet_id] = -1; #special marker
		}

	}
	if( packet_id < lowest_packet_id && type == "cbr" )
		lowest_packet_id = packet_id ;
	if( time < startTime && type == "cbr")
		startTime = time ;
	if ( time > endTime && type == "cbr")
		endTime = time ;
###############packet_sent########################
	if( event == "+" && type == "cbr" ){
		#printf("F:%s,S:%s\n",from,src) ;
		start_time[packet_id] = time ;
		sentPackets += 1; 
	}
###############packet_received####################
	if( event == "r" && type == "cbr" && packet_id >= lowest_packet_id ) { 
		#printf("To:%s,Dst:%s;\n",to,dst) ;
		end_time[packet_id] = time ;
		totalDelay += end_time[packet_id] - start_time[packet_id] ;
		receivedPackets += 1 ;
		receivedBytes += pktsize ;
	}
##############packet_dropped######################
	if( event == "d" && type == "cbr"){
		droppedPackets +=1 ;
	}



}
END{
	totalTime = endTime - startTime ;
	throughput = receivedBytes*8 / totalTime ;
	packetDeliveryRatio = receivedPackets * 100.0 / sentPackets ;
	packetDropRatio = droppedPackets * 100.0 / sentPackets ;

	if( receivedPackets != 0 )
		EndtoEndDelay = totalDelay / receivedPackets ;

	for( packet_id = lowest_packet_id ; packet_id <= highest_packet_id ; packet_id= packet_id + 1000) {
		if(start_time[packet_id]!=-1){
			start = start_time[packet_id] ;
			end = end_time[packet_id] ;
		}	
		
	}
	

	printf( "%15.2f \n%15.5f \n %12d\n %8d\n %8d \n %6.2f\n %10.2f\n %18.2f \n", throughput, EndtoEndDelay, sentPackets, receivedPackets, droppedPackets, packetDeliveryRatio, packetDropRatio, totalTime) ;

}
