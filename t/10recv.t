
use strict;
use Test;


# use a BEGIN block so we print our plan before Net::RTP is loaded
BEGIN { plan tests => 3 }

# load Net::RTP
use Net::RTP;

# Module has loaded sucessfully 
ok(1);


# Create a send object
my $rtp = new Net::RTP('RECVONLY');
ok( defined $rtp );




# Delete the Net::RTP object
undef $rtp;
ok( 1 );



exit;

