//
//	KS_tdes.h
//

#ifndef __KSW_TDES_H__
#define __KSW_TDES_H__

#include "KSdes.h"

/**
 *	Constants
 */

#define	KS_TDES_DIR_ENCRYPT					KS_DES_DIR_ENCRYPT
#define	KS_TDES_DIR_DECRYPT					KS_DES_DIR_DECRYPT

#define	KS_TDES_MAX_KEY_SIZE				(KS_DES_KEY_SIZE * 3)
#define	KS_TDES_MIN_KEY_SIZE				KS_DES_KEY_SIZE

#define	KS_TDES_BLOCK_SIZE					KS_DES_BLOCK_SIZE
#define	KS_TDES_IV_SIZE						KS_DES_IV_SIZE

/**
 *	Struct
 */

typedef struct {
	KS_DES_KEY		key1;
	KS_DES_KEY		key2;
	KS_DES_KEY		key3;
} KS_TDES_KEY;

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

int			KS_TDES_IsWeakKey		(const KS_BYTE *key, const KS_WORD keyLength);

int			KS_TDES_MakeKey			(KS_TDES_KEY *tdesKey, const KS_BYTE *key, 
									 const KS_WORD keyLength, const int dir);

void		KS_TDES_Main			(KS_BYTE output[8], const KS_BYTE input[8], 
									 const KS_TDES_KEY *tdesKey);

// mode

int			KS_TDES_ECB				(KS_BYTE *output,
									 const KS_BYTE *input, const KS_WORD inputLength,
									 const KS_BYTE *key, const KS_WORD keyLength,
									 const int dir);

int			KS_TDES_CBC				(KS_BYTE *output,
									 const KS_BYTE *input, const KS_WORD inputLength,
									 const KS_BYTE *key, const KS_WORD keyLength,
									 KS_BYTE iv[8], const int dir);

int			KS_TDES_CFB				(KS_BYTE *output,
									 const KS_BYTE *input, const KS_WORD inputLength,
									 const KS_BYTE *key, const KS_WORD keyLength,
									 KS_BYTE iv[8], const KS_WORD modeSize, const int dir);

int			KS_TDES_OFB				(KS_BYTE *output,
									 const KS_BYTE *input, const KS_WORD inputLength,
									 const KS_BYTE *key, const KS_WORD keyLength,
									 KS_BYTE iv[8], const KS_WORD modeSize, const int dir);

int			_TDES_CBC				(KS_BYTE *output,
									 const KS_BYTE *input, const KS_WORD inputLength,
									 KS_TDES_KEY *tdesKey, KS_BYTE iv[8], const int dir);

#ifdef __cplusplus
}
#endif

#endif
