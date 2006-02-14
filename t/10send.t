
use strict;
use Test;


# use a BEGIN block so we print our plan before Net::RTP is loaded
BEGIN { plan tests => 10 }

# load Net::RTP
use Net::RTP;

# Module has loaded sucessfully 
ok(1);


# Create a send object
my $rtp = new Net::RTP('SENDONLY');
ok( defined $rtp );


# Enable scheduling mode
$rtp->set_scheduling_mode( 1 );
ok( 1 );

# Enable blocking mode
$rtp->set_blocking_mode( 1 );
ok( 1 );


# Set the remote address
ok($rtp->set_remote_addr( '127.0.0.1', 5004 ) == 0);

# Set the Payload Type 
ok($rtp->set_local_payload_type( 0 ) == 0);

# Set the SSRC 
ok($rtp->set_local_ssrc( 450851100 ) == 0);


# Send a packet (full of NULLs)
my $data = "\0" x 160;
ok( $rtp->send_with_ts( $data, 160 ) == 172 );


# Reset the session
$rtp->reset();
ok(1);

# Delete the Net::RTP object
undef $rtp;
ok( 1 );



exit;

