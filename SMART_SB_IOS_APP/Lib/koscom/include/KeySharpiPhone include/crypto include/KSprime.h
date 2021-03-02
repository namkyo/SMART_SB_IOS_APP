
#ifndef __KSW_PRIME_H__
#define __KSW_PRIME_H__

#include "KSbigint.h"
#include "KSdefine.h"
#include "KSrand.h"

/* ============================
 *		Basic Types
 * ============================ */

typedef struct{
	BigInt	*phiInput;
	BigInt	*oddPart;
	BigInt	*challenge;
	BigInt	*testValue;
	BigInt	*temp;
} MillerRabin_CTX;


/* =============================
 *		Function Prototypes
 * ============================= */

#ifdef __cplusplus
extern "C" {
#endif

void		Big_RandomInt		(BigInt	*randomInt, int	byteLength, LfsrContext *pContext );
KS_WORD		Big_StrongPrime		(BigInt *input, int byteLength, int sieveSize );
int			Big_IsPrime			(BigInt* input);

#ifdef __cplusplus
} // of extern "C"
#endif


#endif
