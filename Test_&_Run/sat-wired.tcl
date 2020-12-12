#
# Contributed by Tom Henderson, November 2001 
#
# Extension of the sat-mixed.tcl script to support integration of
# non-satellite nodes (wired and satellite nodes).  See the documentation
# for usage instructions.  
# 
# $Header: /cvsroot/nsnam/ns-2/tcl/ex/sat-wired.tcl,v 1.1 2001/11/06 06:13:24 tomh Exp $

global ns
set ns [new Simulator]
# Note:  Even though "Static" is normally reserved for static
#        topologies, the satellite code will trigger a recalculation
#        of the routing tables whenever the topology changes.
#	 Therefore, it is not so much "static" as "omniscient", in that
#        topology changes are known instantly throughout the topology.
#        See documentation for discussion of dynamic routing protocols.
$ns rtproto Static

###########################################################################
# Global configuration parameters                                         #
###########################################################################

HandoffManager/Term set elevation_mask_ 40.0;     #teledisc
HandoffManager/Term set term_handoff_int_ 10
HandoffManager set handoff_randomization_ false

global opt
set opt(chan)           Channel/Sat
set opt(bw_down)	1.5Mb; # Downlink bandwidth (satellite to ground)
set opt(bw_up)		1.5Mb; # Uplink bandwidth
set opt(bw_isl)		155Mb; #teledisc
set opt(phy)            Phy/Sat
set opt(mac)            Mac/Sat
set opt(ifq)            Queue/DropTail
set opt(qlim)		50
set opt(ll)             LL/Sat
set opt(wiredRouting)	ON

set opt(alt)		1375; # Polar satellite altitude (Teledisc)
set opt(inc)		85; #Orbit inclination w.r.t. equator(Teledisc)

# IMPORTANT This tracing enabling (trace-all) must precede link and node 
#           creation.  Then following all node, link, and error model
#           creation, invoke "$ns trace-all-satlinks $outfile" 
set outfile [open out.tr w]
$ns trace-all $outfile

###########################################################################
# Set up satellite and terrestrial nodes                                  #
###########################################################################

# Let's first create a single orbital plane of Teledisc-like satellites
# 24 satellites in a plane

# Set up the node configuration

$ns node-config -satNodeType polar \
		-llType $opt(ll) \
		-ifqType $opt(ifq) \
		-ifqLen $opt(qlim) \
		-macType $opt(mac) \
		-phyType $opt(phy) \
		-channelType $opt(chan) \
		-downlinkBW $opt(bw_down) \
		-wiredRouting $opt(wiredRouting)

# Create nodes n0 through n23
set n0 [$ns node]; set n1 [$ns node]; set n2 [$ns node]; set n3 [$ns node] 
set n4 [$ns node]; set n5 [$ns node]; set n6 [$ns node]; set n7 [$ns node] 
set n8 [$ns node]; set n9 [$ns node]; set n10 [$ns node]; set n11 [$ns node] 
set n12 [$ns node]; set n13 [$ns node]; set n14 [$ns node]; set n15 [$ns node] 
set n16 [$ns node]; set n17 [$ns node]; set n18 [$ns node]; set n19 [$ns node]
set n20 [$ns node]; set n21 [$ns node]; set n22 [$ns node]; set n23 [$ns node]

# Now provide position information for each of these nodes
# Position arguments are: altitude, incl., longitude, "alpha", and plane
# See documentation for definition of these fields
set plane 1
$n0 set-position $opt(alt) $opt(inc) 0 0 $plane 
$n1 set-position $opt(alt) $opt(inc) 0 15.0 $plane
$n2 set-position $opt(alt) $opt(inc) 0 30.0 $plane
$n3 set-position $opt(alt) $opt(inc) 0 45.0 $plane
$n4 set-position $opt(alt) $opt(inc) 0 60.0 $plane
$n5 set-position $opt(alt) $opt(inc) 0 75.0 $plane
$n6 set-position $opt(alt) $opt(inc) 0 90.0 $plane
$n7 set-position $opt(alt) $opt(inc) 0 105.0 $plane
$n8 set-position $opt(alt) $opt(inc) 0 120.0 $plane
$n9 set-position $opt(alt) $opt(inc) 0 135.0 $plane
$n10 set-position $opt(alt) $opt(inc) 0 150.0 $plane
$n11 set-position $opt(alt) $opt(inc) 0 165.0 $plane 
$n12 set-position $opt(alt) $opt(inc) 0 180.0 $plane
$n13 set-position $opt(alt) $opt(inc) 0 195.0 $plane
$n14 set-position $opt(alt) $opt(inc) 0 210.0 $plane
$n15 set-position $opt(alt) $opt(inc) 0 225.0 $plane
$n16 set-position $opt(alt) $opt(inc) 0 240.0 $plane
$n17 set-position $opt(alt) $opt(inc) 0 255.0 $plane
$n18 set-position $opt(alt) $opt(inc) 0 270.0 $plane
$n19 set-position $opt(alt) $opt(inc) 0 285.0 $plane
$n20 set-position $opt(alt) $opt(inc) 0 300.0 $plane
$n21 set-position $opt(alt) $opt(inc) 0 315.0 $plane
$n22 set-position $opt(alt) $opt(inc) 0 330.0 $plane
$n23 set-position $opt(alt) $opt(inc) 0 345.0 $plane


# This next step is specific to polar satellites
# By setting the next_ variable on polar sats; handoffs can be optimized  
# This step must follow all polar node creation
$n0 set_next $n23; $n1 set_next $n0; $n2 set_next $n1; $n3 set_next $n2
$n4 set_next $n3; $n5 set_next $n4; $n6 set_next $n5; $n7 set_next $n6
$n8 set_next $n7; $n9 set_next $n8; $n10 set_next $n9; $n11 set_next $n10
$n12 set_next $n11; $n13 set_next $n12; $n14 set_next $n13; $n15 set_next $n14
$n16 set_next $n15; $n17 set_next $n16; $n18 set_next $n17; $n19 set_next $n18
$n20 set_next $n19; $n21 set_next $n20; $n22 set_next $n21; $n23 set_next $n22

# GEO satellite:  above Dhaka-- lets put it at 90 deg. E
$ns node-config -satNodeType geo
set n24 [$ns node]
$n24 set-position 90

# Terminals:  Let's put two within Asia, two around the prime meridian
$ns node-config -satNodeType terminal 
set n200 [$ns node]; set n201 [$ns node]
$n200 set-position 19.1 72.9; # Mumbai
$n201 set-position 39.9 116.4; # Beijing
set n300 [$ns node]; set n301 [$ns node]
$n300 set-position 0 10 
$n301 set-position 0 -10

###########################################################################
# Set up links                                                            #
###########################################################################

# Add any necessary ISLs or GSLs
# GSLs to the geo satellite:
$n200 add-gsl geo $opt(ll) $opt(ifq) $opt(qlim) $opt(mac) $opt(bw_up) \
  $opt(phy) [$n24 set downlink_] [$n24 set uplink_]
$n201 add-gsl geo $opt(ll) $opt(ifq) $opt(qlim) $opt(mac) $opt(bw_up) \
  $opt(phy) [$n24 set downlink_] [$n24 set uplink_]
# Attach n300 and n301 initially to a satellite on other side of the earth
# (handoff will automatically occur to fix this at the start of simulation)
$n300 add-gsl polar $opt(ll) $opt(ifq) $opt(qlim) $opt(mac) $opt(bw_up) \
  $opt(phy) [$n5 set downlink_] [$n5 set uplink_]
$n301 add-gsl polar $opt(ll) $opt(ifq) $opt(qlim) $opt(mac) $opt(bw_up) \
  $opt(phy) [$n5 set downlink_] [$n5 set uplink_]

# ISLs for the polar satellites
$ns add-isl intraplane $n0 $n1 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n1 $n2 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n2 $n3 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n3 $n4 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n4 $n5 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n5 $n6 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n6 $n7 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n7 $n8 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n8 $n9 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n9 $n10 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n10 $n11 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n11 $n12 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n12 $n13 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n13 $n14 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n14 $n15 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n15 $n16 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n16 $n17 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n17 $n18 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n18 $n19 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n19 $n20 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n20 $n21 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n21 $n22 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n22 $n23 $opt(bw_isl) $opt(ifq) $opt(qlim)
$ns add-isl intraplane $n23 $n0 $opt(bw_isl) $opt(ifq) $opt(qlim)


###########################################################################
# Set up wired nodes                                                      #
###########################################################################
# Connect $n400 <-> $n401 <-> $n402 <-> $n400 <-> $n24 <-> $n401 <-> $n403
#                      ^                   ^
#                      |___________________|    
#
# Packets from n403 to n400 should bypass n402 (node #31 in the trace)
# (i.e., these packets should take the following path:  32,26,24,25,30,29)
#
$ns unset satNodeType_
set n400 [$ns node]; # node 29 in trace
set n401 [$ns node]; # node 30 in trace
set n402 [$ns node]; # node 31 in trace
set n403 [$ns node]; # node 32 in trace
$ns duplex-link $n400 $n401 5Mb 2ms DropTail; # 29 <-> 30
$ns duplex-link $n401 $n402 5Mb 2ms DropTail; # 30 <-> 31
$ns duplex-link $n402 $n200 5Mb 2ms DropTail; # 31 <-> 24
$ns duplex-link $n403 $n201 5Mb 2ms DropTail; # 32 <-> 26
$ns duplex-link $n401 $n200 5Mb 2ms DropTail; # 30 <-> 24


###########################################################################
# Tracing                                                                 #
###########################################################################
$ns trace-all-satlinks $outfile

###########################################################################
# Attach agents                                                           #
###########################################################################

set udp0 [new Agent/UDP]
$ns attach-agent $n200 $udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0
$cbr0 set interval_ 60.01

set udp1 [new Agent/UDP]
$ns attach-agent $n300 $udp1
$udp1 set class_ 1
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1
$cbr1 set interval_ 90.5

set null0 [new Agent/Null]
$ns attach-agent $n201 $null0
set null1 [new Agent/Null]
$ns attach-agent $n301 $null1

$ns connect $udp0 $null0
$ns connect $udp1 $null1

###########################################################################
# Set up connection between wired nodes                                   #
###########################################################################
set udp2 [new Agent/UDP]
$ns attach-agent $n403 $udp2
set cbr2 [new Application/Traffic/CBR]
$cbr2 attach-agent $udp2
$cbr2 set interval_ 300
set null2 [new Agent/Null]
$ns attach-agent $n400 $null2

$ns connect $udp2 $null2
$ns at 10.0 "$cbr2 start"

###########################################################################
# Satellite routing                                                       #
###########################################################################

set satrouteobject_ [new SatRouteObject]
$satrouteobject_ compute_routes
#$satrouteobject_ set wiredRouting_ true

$ns at 1.0 "$cbr0 start"
$ns at 305.0 "$cbr1 start"
#$ns at 0.9 "$cbr1 start"

$ns at 9000.0 "finish"

proc finish {} {
	global ns outfile 
	$ns flush-trace
	close $outfile

	exit 0
}

$ns run

