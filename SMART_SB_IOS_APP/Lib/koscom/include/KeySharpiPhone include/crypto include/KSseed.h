
#ifndef __KSW_SEED_H__
#define __KSW_SEED_H__

#include "KSdefine.h"

/**
 *	Constants
 */

#define	SEED_ENCRYPT				0
#define	SEED_DECRYPT				1

#define	SEED_ROUNDKEY_SIZE			32		
#define	SEED_BLOCK_SIZE				16		
#define	SEED_KEY_SIZE				16		
#define	SEED_IV_SIZE				16		

/**
 *	Error codes
 */

#define	SEED_ERROR_INVALID_KEY		-100
#define	SEED_ERROR_INVALID_INPUT	-101

/**
 *	Prototypes
 */

#ifdef __cplusplus
extern "C" {
#endif

void SEED_MakeKey			(KS_WORD *pdwRoundKey, KS_BYTE *pbUserKey, int dir);
void SEED_Main				(KS_BYTE *output, KS_BYTE *input, KS_WORD *roundKey);
int  SEED_CBC_Encrypt		(KS_BYTE *psOutput, KS_BYTE *psInput, KS_WORD nInputLength,
									 KS_BYTE *psIV, KS_BYTE *psKey);
int  SEED_CBC_Decrypt		(KS_BYTE *psOutput, KS_BYTE *psInput, KS_WORD nInputLength,
									 KS_BYTE *psIV, KS_BYTE *psKey);
int SEED_CBC_Encrypt_		(KS_BYTE *psOutput, KS_BYTE *psInput, KS_WORD nInputLength, KS_BYTE *psIV, KS_BYTE *psKey);

int  _SEED_CBC				(KS_BYTE *psOutput,
							 KS_BYTE *psInput, KS_WORD nInputLength,
							 KS_BYTE *psIV, KS_WORD *psRoundKey, const int dir);

#ifdef __cplusplus
}
#endif

#endif
