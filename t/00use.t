
use strict;
use Test;


# use a BEGIN block so we print our plan before Net::RTP is loaded
BEGIN { plan tests => 1 }

# load Net::RTP
use Net::RTP;


# Helpful notes.  All note-lines must start with a "#".
print "# I'm testing Net::RTP version $Net::RTP::VERSION\n";

# Module has loaded sucessfully 
ok(1);




exit;

