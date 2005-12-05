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
#include <sys/socket.h>
#include <net/if.h>
#include <ifaddrs.h>

#include <ortp.h>


MODULE = Net::RTP	PACKAGE = Net::RTP


