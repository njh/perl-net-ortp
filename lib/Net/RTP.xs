/*

	Net::RTP: Real-time Transport Protocol (rfc3550)

	Nicholas Humfrey
	University of Southampton
	njh@ecs.soton.ac.uk
	
*/

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

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

void
rtp_session_enable_adaptive_jitter_compensation(session,val)
	RtpSession*	session
	int			val


void
rtp_session_set_ssrc(session,ssrc)
	RtpSession*	session
	int			ssrc

void
rtp_session_set_seq_number(session,seq)
	RtpSession*	session
	int			seq

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



