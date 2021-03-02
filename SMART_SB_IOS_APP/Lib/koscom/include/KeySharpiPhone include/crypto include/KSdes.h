//
//	KS_des.h
//  최성훈

#ifndef __KSW_DES_H__
#define __KSW_DES_H__

#include "KSdefine.h"

/**
 *	Constants
 */

#define	KS_DES_DIR_ENCRYPT					0
#define	KS_DES_DIR_DECRYPT					1

#define	KS_DES_KEY_SIZE						8		// BYTE

#define	KS_DES_BLOCK_SIZE					8		// BYTE
#define	KS_DES_IV_SIZE						8		// BYTE

/**
 *	Struct
 */

typedef struct {
	KS_WORD		roundKey[32];
} KS_DES_KEY;

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

int			KS_DES_IsWeakKey		(const KS_BYTE key[8]);

void		KS_DES_MakeKey			(KS_DES_KEY *desKey, const KS_BYTE key[8], 
									 const int dir);

void		KS_DES_IP				(KS_WORD *left, KS_WORD *right);
void		KS_DES_Core				(KS_WORD *left, KS_WORD *right, const KS_DES_KEY *desKey);
void		KS_DES_FP				(KS_WORD *left, KS_WORD *right);

void		KS_DES_Main				(KS_BYTE output[8], const KS_BYTE input[8], 
									 const KS_DES_KEY *desKey);

// mode

int			KS_DES_ECB				(KS_BYTE *output,
									 const KS_BYTE *input, const KS_WORD inputLength,
									 const KS_BYTE key[8], const int dir);

int			KS_DES_CBC				(KS_BYTE *output,
									 const KS_BYTE *input, const KS_WORD inputLength,
									 const KS_BYTE key[8], KS_BYTE iv[8], const int dir);

int			KS_DES_CFB				(KS_BYTE *output,
									 const KS_BYTE *input, const KS_WORD inputLength,
									 const KS_BYTE key[8], KS_BYTE iv[8], 
									 const KS_WORD modeSize, const int dir);

int			KS_DES_OFB				(KS_BYTE *output,
									 const KS_BYTE *input, const KS_WORD inputLength,
									 const KS_BYTE key[8], KS_BYTE iv[8], 
									 const KS_WORD modeSize, const int dir);

int			_DES_CBC				(KS_BYTE *output,
									 const KS_BYTE *input, const KS_WORD nInputLength,
									 KS_DES_KEY *desKey, KS_BYTE iv[8], const int dir);

int			KS_DES_MAC				(KS_BYTE *output, 
									   const KS_BYTE *input, 
									   const KS_WORD nInputLength,
									   const KS_BYTE key[8], 
									   KS_BYTE iv[8]);
#ifdef __cplusplus
}
#endif

#endif
