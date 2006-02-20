#!/usr/bin/perl
#
# Net::RTP example file
#
# Send a fixed tone containing PCMA audio 
# to specified address and port
#
#

use Net::RTP;
use strict;


# Nice crunchy 800Hz tone in PCMU:
my @pcmu_tone_ = (0x01, 0x0D, 0xFF, 0x8D, 0x81, 0x81, 0x8D, 0xFF, 0x0D, 0x01);
my @pcmu_silence = (0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x7F, 0x7F);

# 0.5 second tone followed by 1.0 seconds of silence
my @pcmu = ();
for(0...400) { print push(@pcmu, @tone_pcmu); }
for(0...800) { print pack(@pcmu, @silence_pcmu ); }



# Check the number of arguments
if ($#ARGV != 1) {
	print "usage: rtpsendtone.pl dest_addr dest_port\n";
	exit;
}

# Get the command line parameters
my ($address, $port ) = @ARGV;
print "Remote Address: $address\n";
print "Remote Port: $port\n";



# Create a send object
my $rtp = new Net::RTP('SENDONLY');

# Set it up
$rtp->set_scheduling_mode( 1 );
$rtp->set_blocking_mode( 1 );
$rtp->set_remote_addr( $address, $port );
$rtp->set_send_payload_type( 0 );


my $user_ts = 0;
my $ts_step = 120;
while( my $read = read( PCMU, $data, 120 ) ) {
	#print "Read $read bytes.\n";
	
	my $sent = $rtp->send_with_ts( pack('C*', $data), $user_ts );
	#print "Sent $sent bytes.\n";
	
	# Increment the timestamp
	$user_ts+=120;
	
	print ".";
}

