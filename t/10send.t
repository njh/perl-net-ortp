
use strict;
use Test;


# use a BEGIN block so we print our plan before Net::RTP is loaded
BEGIN { plan tests => 2 }

# load Net::RTP
use Net::RTP;

# Module has loaded sucessfully 
ok(1);


# Create a send object
my $rtp = new Net::RTP('SEND');
ok( defined $rtp );


# Enable scheduling mode
$rtp->set_scheduling_mode( 1 );
ok( 1 );

# Enable blocking mode
$rtp->set_blocking_mode( 1 );
ok( 1 );





# Delete the Net::RTP object
undef $rtp;
ok( 1 );



exit;

