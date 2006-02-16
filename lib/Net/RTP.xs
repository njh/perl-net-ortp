/*

	Net::RTP: Real-time Transport Protocol (rfc3550)

	Nicholas Humfrey
	University of Southampton
	njh@ecs.soton.ac.uk
	
*/

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <stdio.h>
#include <sys/types.h>
#include <ortp/ortp.h>


MODULE = Net::RTP	PACKAGE = Net::RTP


## Library initialisation
void
ortp_initialize()
  CODE:
	ortp_set_log_level_mask( ORTP_WARNING|ORTP_ERROR|ORTP_FATAL );
	ortp_init();
	ortp_scheduler_init();

void
ortp_shutdown()
  CODE:
	ortp_exit();




## Session Stuff
RtpSession*
rtp_session_new(mode)
	int mode
  CODE:
  	RETVAL=rtp_session_new(mode);
  	rtp_session_signal_connect(RETVAL,"ssrc_changed",(RtpCallback)rtp_session_reset,0);
  OUTPUT:
	RETVAL
	
	
void
rtp_session_set_scheduling_mode(session,yesno)
	RtpSession*	session
	int			yesno
	
void
rtp_session_set_blocking_mode(session,yesno)
	RtpSession*	session
	int			yesno

int
rtp_session_set_local_addr(session,addr,port)
	RtpSession*	session
	const char*	addr
	int			port

int
rtp_session_get_local_port(session)
	RtpSession* session
	
int
rtp_session_set_remote_addr(session,addr,port)
	RtpSession*	session
	const char*	addr
	int			port

void
rtp_session_set_jitter_compensation(session,milisec)
	RtpSession*	session
	int			milisec

int
rtp_session_get_jitter_compensation(session)
	RtpSession*	session
  CODE:
	RETVAL = session->rtp.jittctl.jitt_comp;
  OUTPUT:
	RETVAL
	

void
rtp_session_enable_adaptive_jitter_compensation(session,val)
	RtpSession*	session
	int			val

int
rtp_session_adaptive_jitter_compensation_enabled(session)
	RtpSession*	session
  CODE:
	RETVAL = rtp_session_adaptive_jitter_compensation_enabled( session );
  OUTPUT:
	RETVAL


void
rtp_session_set_ssrc(session,ssrc)
	RtpSession*	session
	int			ssrc
	
int
rtp_session_get_send_ssrc(session)
	RtpSession*	session
  CODE:
	RETVAL = session->send_ssrc;
  OUTPUT:
	RETVAL

void
rtp_session_set_seq_number(session,seq)
	RtpSession*	session
	int			seq

int
rtp_session_get_send_seq_number(session)
	RtpSession*	session
  CODE:
	RETVAL = session->rtp.snd_seq;
  OUTPUT:
	RETVAL

int
rtp_session_set_send_payload_type(session,pt)
	RtpSession*	session
	int			pt

int
rtp_session_get_send_payload_type(session)
	RtpSession*	session

int
rtp_session_get_recv_payload_type(session)
	RtpSession*	session
	
int
rtp_session_set_recv_payload_type(session,pt)
	RtpSession*	session
	int			pt

int
rtp_session_send_with_ts(session,sv,userts)
	RtpSession*	session
	SV*			sv
	int			userts
  PREINIT:
	STRLEN len = 0;
	const char * ptr = NULL;
  CODE:
  	ptr = SvPV( sv, len );
  	RETVAL = rtp_session_send_with_ts( session, ptr, len, userts );
  OUTPUT:
	RETVAL


SV*
rtp_session_recv_with_ts(session,wanted,userts)
	RtpSession*	session
	int			wanted
	int			userts
  PREINIT:
  	char* buffer = malloc( wanted );
  	char* ptr = buffer;
  	int buf_len = wanted;
  	int buf_used=0, bytes=0;
  	int have_more=1;
  CODE:
	while (have_more) {
		bytes = rtp_session_recv_with_ts(session,ptr,buf_len-buf_used,userts,&have_more);
		if (bytes<=0) break;
		buf_used += bytes;
		
		// Allocate some more memory
		if (have_more) {
			buffer = realloc( buffer, buf_len + wanted );
			buf_len += wanted;
			ptr += bytes;
		}
	}
	
	if (bytes<=0) {
 		RETVAL = &PL_sv_undef;
  	} else {
		RETVAL = newSVpvn( buffer, buf_used );
  	}
  	
  	free( buffer );
  OUTPUT:
	RETVAL


void
rtp_session_flush_sockets(session)
	RtpSession*	session
	
void
rtp_session_release_sockets(session)
	RtpSession*	session
	
void
rtp_session_reset(session)
	RtpSession*	session

	
void
rtp_session_destroy(session)
	RtpSession*	session



