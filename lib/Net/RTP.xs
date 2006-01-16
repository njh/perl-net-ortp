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
ortp_init()

void
ortp_scheduler_init()

void
ortp_exit()


