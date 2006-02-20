package Net::RTP;

################
#
# Net::RTP: Real-time Transport Protocol (RFC3550)
#
# Uses the oRTP library.
#
# Nicholas Humfrey
# njh@ecs.soton.ac.uk
#

use strict;
use XSLoader;
use Carp;

use vars qw/$VERSION/;

$VERSION="0.01";

# Number of Net::RTP objects created
my $OBJCOUNT=0;


XSLoader::load('Net::RTP', $VERSION);



sub new {
    my $class = shift;
    my ($mode) = @_;
    
    # Initialise the ortp library?
    if ($OBJCOUNT==0) {
	   	ortp_initialize();
    }
    $OBJCOUNT++;

    
	# Work out the multicast group to use
    croak "Missing mode parameter" unless defined $mode;
    
	# Convert mode name to mode enum
    my $mnum = undef;
    if    ($mode eq 'RECVONLY') { $mnum = 0; }
    elsif ($mode eq 'SENDONLY') { $mnum = 1; }
	elsif ($mode eq 'SENDRECV') { $mnum = 2; }
	else {
		croak "Invalid mode: $mode";
	}
	
	# Create new session
	my $session = rtp_session_new( $mnum );
	unless (defined $session) { 
		die "Failed to create RTP session";
	}

	# Store parameters
    my $self = {
    	'mode'	=> $mode,
    	'session' => $session
    };


    bless $self, $class;
	return $self;
}


sub set_scheduling_mode {
    my $self=shift;
	my ($yesno) = @_;
	return rtp_session_set_scheduling_mode( $self->{'session'}, $yesno );
}

sub set_blocking_mode {
    my $self=shift;
	my ($yesno) = @_;
	return rtp_session_set_blocking_mode( $self->{'session'}, $yesno );
}

sub set_local_addr {
    my $self=shift;
	my ($addr, $port) = @_;

	return rtp_session_set_local_addr( $self->{'session'}, $addr, $port );
}

sub get_local_port {
    my $self=shift;
	my ($addr, $port) = @_;
	return rtp_session_get_local_port( $self->{'session'} );
}

sub set_remote_addr {
    my $self=shift;
	my ($addr, $port) = @_;
	return rtp_session_set_remote_addr( $self->{'session'}, $addr, $port );
}

sub get_jitter_compensation {
    my $self=shift;
	return rtp_session_get_jitter_compensation( $self->{'session'} );
}

sub set_jitter_compensation {
    my $self=shift;
	my ($milisec) = @_;
	return rtp_session_set_jitter_compensation( $self->{'session'}, $milisec );
}

sub set_adaptive_jitter_compensation {
    my $self=shift;
	my ($yesno) = @_;
	return rtp_session_enable_adaptive_jitter_compensation( $self->{'session'}, $yesno );
}

sub get_adaptive_jitter_compensation {
    my $self=shift;
	return rtp_session_adaptive_jitter_compensation_enabled( $self->{'session'} );
}

sub set_send_ssrc {
    my $self=shift;
	my ($ssrc) = @_;
	return rtp_session_set_ssrc( $self->{'session'}, $ssrc );
}

sub get_send_ssrc {
    my $self=shift;
	return rtp_session_get_send_ssrc( $self->{'session'} );
}

sub set_send_seq_number {
    my $self=shift;
	my ($seq) = @_;
	return rtp_session_set_seq_number( $self->{'session'}, $seq );
}

sub get_send_seq_number {
    my $self=shift;
	return rtp_session_get_send_seq_number( $self->{'session'} );
}

sub set_send_payload_type {
    my $self=shift;
	my ($pt) = @_;
	return rtp_session_set_send_payload_type( $self->{'session'}, $pt );
}

sub get_send_payload_type {
    my $self=shift;
	return rtp_session_get_send_payload_type( $self->{'session'} );
}

sub set_recv_payload_type {
    my $self=shift;
	my ($pt) = @_;
	return rtp_session_set_recv_payload_type( $self->{'session'}, $pt );
}

sub get_recv_payload_type {
    my $self=shift;
	return rtp_session_get_recv_payload_type( $self->{'session'} );
}

sub recv_with_ts {
    my $self=shift;
	my ($bytes, $userts) = @_;
	return rtp_session_recv_with_ts( $self->{'session'}, $bytes, $userts ) ;
}

sub send_with_ts {
    my $self=shift;
	my ($data, $userts) = @_;
	return rtp_session_send_with_ts( $self->{'session'}, $data, $userts );
}

sub flush_sockets {
    my $self=shift;
	return rtp_session_flush_sockets( $self->{'session'} );
}

sub release_sockets {
    my $self=shift;
	return rtp_session_release_sockets( $self->{'session'} );
}

sub reset {
    my $self=shift;
	return rtp_session_reset( $self->{'session'} );
}



sub DESTROY {
    my $self=shift;
    
    if (exists $self->{'session'}) {
    	rtp_session_destroy( $self->{'session'} );
    }

    # Decrement the number of Net::RTP objects
    $OBJCOUNT--;
    if ($OBJCOUNT==0) {
    	ortp_shutdown();
    } elsif ($OBJCOUNT<0) {
    	warn "Warning: Net::RTP object count is less than 0.";
    }
}



1;

__END__

=pod

=head1 NAME

Net::RTP - Real-time Transport Protocol (RFC3550)

=head1 SYNOPSIS

  use Net::RTP;

  my $rtp = Net::RTP->new( 'RECVONLY' );



=head1 DESCRIPTION

Net::RTP 



=head1 AUTHOR

Nicholas Humfrey, njh@ecs.soton.ac.uk

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 University of Southampton

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
