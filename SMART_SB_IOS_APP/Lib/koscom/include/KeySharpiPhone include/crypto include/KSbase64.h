//
//	KS_base64.h
//

#ifndef	__KSW_BASE64_H__
#define	__KSW_BASE64_H__

#include "KSdefine.h"


#ifdef  __cplusplus
extern "C" {
#endif

int BASE64_Encode		(ks_uint8 *output, ks_uint8 *input, int length);
int BASE64_Decode		(ks_uint8 *output, ks_uint8 *input, int length);

#ifdef	__cplusplus
}
#endif

#endif
