#!/usr/bin/perl
#
# Net::RTP example file
#
# Send a file containing PCMU audio 
# to specified address and port
#
# File can be generated using:
# sox input.aiff -t raw -b -U -c 1 -r 8000 output.raw
#

use Net::RTP;
use strict;


# Create a send object
my $rtp = new Net::RTP('RECVONLY');

# Set it up
$rtp->set_scheduling_mode( 1 );
$rtp->set_blocking_mode( 1 );
#$rtp->set_local_addr( '233.3.18.2', 10002 );
$rtp->set_local_addr( '233.3.18.3', 10002 );
$rtp->set_remote_addr( '233.3.18.3', 10002 );
$rtp->set_recv_payload_type( 0 );


my $data;
my $user_ts = 0;
while( 1 ) {
	my $data = $rtp->recv_with_ts( $user_ts );
	if ($data) {
		print "Got ".length($data)." bytes\n";
	}
	
	$user_ts++;
}	

