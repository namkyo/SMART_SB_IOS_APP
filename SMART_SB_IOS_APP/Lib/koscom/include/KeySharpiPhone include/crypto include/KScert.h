#ifndef	__KSW_CERT_H__
#define	__KSW_CERT_H__

#include "KSdefine.h"

#ifdef  __cplusplus
extern "C" {
#endif

/**
 *	CERT_IsAcceptable :
 *
 *	input  : cert			: pointer to certificate
 *			 cert_length	: length of certificate
 *			 org 			: issuer - optional
 *			 oid		 	: policy oid - optional(NULL)
 *			 oid_length		: length of policy oid - optional(0)
 *
 *	return : 0/1	: 0 = unacceptable/ 1 = accepatable
 *
 *  caution - org and oid, one of them or both must be used.
 */
int CERT_IsAcceptable(ks_uint8 *cert, int cert_length, char *org, 
					  ks_uint8 *oid, int oid_length);

#ifdef  __cplusplus
}
#endif

#endif
