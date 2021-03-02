//
//	KS_cbcmac.h
//

#ifndef __KSW_CBCMAC_H__
#define __KSW_CBCMAC_H__

#include "KScipher.h"

/**
 *	Constants
 */

#define	KS_CBCMAC_ID_AES					KS_CIPHER_ID_AES
#define	KS_CBCMAC_ID_BLOWFISH				KS_CIPHER_ID_BLOWFISH
#define	KS_CBCMAC_ID_CAST128				KS_CIPHER_ID_CAST128
#define	KS_CBCMAC_ID_DES					KS_CIPHER_ID_DES
#define KS_CBCMAC_ID_RC2					KS_CIPHER_ID_RC2
#define KS_CBCMAC_ID_RC5					KS_CIPHER_ID_RC5
#define KS_CBCMAC_ID_SEED					KS_CIPHER_ID_SEED
#define KS_CBCMAC_ID_SKIPJACK				KS_CIPHER_ID_SKIPJACK
#define KS_CBCMAC_ID_TDES					KS_CIPHER_ID_TDES
#define KS_CBCMAC_ID_DEFAULT			 	KS_CBCMAC_ID_DES

#define	KS_CBCMAC_MAX_KEY_SIZE				KS_CIPHER_MAX_KEY_SIZE
#define KS_CBCMAC_MAX_DIGEST_SIZE			KS_CIPHER_MAX_BLOCK_SIZE

/**
 *	Struct
 */

typedef struct {
	int			cbcmacID;
	KS_CIPHER_CTX	cipherContext;
} KS_CBCMAC_CTX;

/**
 *	Error codes
 */

//	KS_COMMON_ERROR_INVALID_INPUT
//
//	KS_CBCMAC_ERROR_UNKNOWN_ID

/**
 *	Prototypes
 */

#ifdef __cplusplus
extern "C" {
#endif

KS_ERROR	KS_CBCMAC_Init			(KS_CBCMAC_CTX *ctx, 
									 const KS_BYTE *key, const KS_WORD keyLength,
									 const int cbcmacID, const KS_CIPHER_SUITE_PARAM *suiteParam);

KS_ERROR	KS_CBCMAC_Update		(KS_CBCMAC_CTX *ctx, 
									 const KS_BYTE *input, const KS_WORD inputLength);

KS_ERROR	KS_CBCMAC_Final			(KS_CBCMAC_CTX *ctx, KS_BYTE *mac, KS_WORD *macLength);

KS_ERROR	KS_CBCMAC				(KS_BYTE *mac, KS_WORD *macLength, 
									 const KS_BYTE *input, const KS_WORD inputLength,
									 const KS_BYTE *key, const KS_WORD keyLength,
									 const int cbcmacID, const KS_CIPHER_SUITE_PARAM *suiteParam);

#ifdef __cplusplus
}
#endif

#endif
