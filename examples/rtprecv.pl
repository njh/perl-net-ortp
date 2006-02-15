#!/usr/bin/perl
#
# Net::RTP example file
#
# Send a file containing PCMU audio 
# to specified address and port
#
# The raw output file can be converted to an AIFF using
# sox -t raw -b -U -c 1 -r 8000 audio.raw output.aiff
#

use Net::RTP;
use strict;


# Unbuffered
$|=1;

# Check the number of arguments
if ($#ARGV != 2) {
	print "usage: rtpsend.pl filename dest_addr dest_port\n";
	exit;
}

# Get the command line parameters
my ($filename, $address, $port ) = @ARGV;
print "Output Filename: $filename\n";
print "Remote Address: $address\n";
print "Remote Port: $port\n";



# Create a send object
my $rtp = new Net::RTP('RECVONLY');

# Set it up
$rtp->set_scheduling_mode( 1 );
$rtp->set_blocking_mode( 1 );
$rtp->set_local_addr( $address, $port );
$rtp->set_recv_payload_type( 0 );


# Open the input file
open(PCMU, ">$filename") or die "Failed to open output file: $!";


my $data;
my $user_ts = 0;
while( 1 ) {
	my $data = $rtp->recv_with_ts( 160, $user_ts );
	if (defined $data) {
		print "Got ".length($data)." bytes\n";
		print PCMU $data;
		$user_ts+=160;
	} else {
		warn "Failed to recieve packet";
	}

}	


close( PCMU );
