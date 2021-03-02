//
//	KS_rc2.h
//

#ifndef __KSW_RC2_H__
#define __KSW_RC2_H__

#include "KSdefine.h"

/**
 *	Constants
 */

#define	KS_RC2_DIR_ENCRYPT					0
#define	KS_RC2_DIR_DECRYPT					1

// variable key size (0 bits ~ 1024 bits)
#define	KS_RC2_MAX_KEY_SIZE					128
#define	KS_RC2_MIN_KEY_SIZE					1

#define	KS_RC2_BLOCK_SIZE					8		// BYTE
#define	KS_RC2_IV_SIZE						8		// BYTE

/**
 *	Struct
 */

typedef struct {
	KS_WORD		roundKey[64];
} KS_RC2_KEY;

/**
 *	Error codes
 */

//	KS_COMMON_ERROR_INVALID_INPUT

/**
 *	Prototypes
 */

#ifdef __cplusplus
extern "C" {
#endif

void		KS_RC2_MakeKey			(KS_RC2_KEY *rc2Key, const KS_BYTE *key, 
									 const KS_WORD keyLength, const KS_WORD effectiveBits);

void		KS_RC2_Main				(KS_BYTE output[8], const KS_BYTE input[8], 
									 const KS_RC2_KEY *rc2Key, const int dir);

// mode

int			KS_RC2_ECB				(KS_BYTE *output, KS_WORD *outputLength,
									 const KS_BYTE *input, const KS_WORD inputLength,
									 const KS_BYTE *key, const KS_WORD keyLength, 
									 const KS_WORD effectiveBits,
									 const int dir);

int			KS_RC2_CBC				(KS_BYTE *output, KS_WORD *outputLength,
									 const KS_BYTE *input, const KS_WORD inputLength,
									 const KS_BYTE *key, const KS_WORD keyLength,
									 const KS_WORD effectiveBits,
									 KS_BYTE iv[8], const int dir);

#ifdef __cplusplus
}
#endif

#endif
