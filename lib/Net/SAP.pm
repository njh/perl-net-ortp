package Net::RTP;

################
#
# Net::RTP: Real-time Transport Protocol (rfc3550)
#
# Nicholas Humfrey
# njh@ecs.soton.ac.uk
#

use strict;
use XSLoader;
use Carp;

use Net::RTP::Session;

use vars qw/$VERSION $PORT/;

$VERSION="0.01";


XSLoader::load('Net::RTP', $VERSION);



sub new {
    my $class = shift;
    my ($mode) = @_;
    
    
	# Work out the multicast group to use
    croak "Missing mode parameter" unless defined $mode;


	# Store parameters
    my $self = {
    	'mode'	=> $group,
    	'session'	=> undef
    };
    
        

    bless $self, $class;
	return $self;
}



sub DESTROY {
    my $self=shift;
    
    if (exists $self->{'session'}) {
    	
    	#rtp_session_reset 
    }
}


1;

__END__

=pod

=head1 NAME

Net::RTP - Real-time Transport Protocol (rfc3550)

=head1 SYNOPSIS

  use Net::RTP;

  my $rtp = Net::RTP->new( 'RECVONLY' );



=head1 DESCRIPTION

Net::RTP 



=head1 AUTHOR

Nicholas Humfrey, njh@ecs.soton.ac.uk

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2005 University of Southampton

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

=cut
