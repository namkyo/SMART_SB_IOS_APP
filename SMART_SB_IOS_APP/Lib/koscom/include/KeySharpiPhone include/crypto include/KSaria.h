//
//	ks_aria.h
//
#ifndef __KSW_ARIA_H__
#define __KSW_ARIA_H__

#include "KSdefine.h"

#define	KS_ARIA_DIR_ENCRYPT					0
#define	KS_ARIA_DIR_DECRYPT					1

#define	KS_ARIA_MAX_KEY_SIZE				32		// 256 bits, bytes Block
#define	KS_ARIA_MIN_KEY_SIZE				16		// 128 bits, bytes Block

#define	KS_ARIA_BLOCK_SIZE					16		// BYTE
#define	KS_ARIA_IV_SIZE						16		// BYTE

typedef struct {
	KS_WORD	rounds;
	KS_WORD		keyLength;
	KS_WORD		roundKey[16*(16+1)];
} _KS_ARIA_KEY;

#ifdef __cplusplus
extern "C" {
#endif
	
int _KS_ARIA_GenerateKey(_KS_ARIA_KEY *ariaKey, KS_BYTE *key, KS_WORD keyLength, int dir);
void _KS_ARIA_Main(_KS_ARIA_KEY *ariaKey, KS_BYTE output[16], KS_BYTE input[16]);

int ARIA_CBC_Decrypt(KS_BYTE *psOutput, KS_BYTE *psInput, KS_WORD nInputLength, KS_BYTE *psIV, KS_BYTE *psKey, KS_WORD psKeyLength);
int ARIA_CBC_Encrypt_(KS_BYTE *psOutput, KS_BYTE *psInput, KS_WORD nInputLength, KS_BYTE *psIV, KS_BYTE *psKey, KS_WORD psKeyLength);
int ARIA_CBC_Encrypt(KS_BYTE *psOutput, KS_BYTE *psInput, KS_WORD nInputLength, KS_BYTE *psIV,  KS_BYTE *psKey, KS_WORD psKeyLength);

#ifdef __cplusplus
}
#endif

#endif
