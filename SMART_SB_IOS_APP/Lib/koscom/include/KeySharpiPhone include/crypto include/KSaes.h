#ifndef __KSW_AES_H__
#define __KSW_AES_H__

#include "KSdefine.h"

#define	AES_DIR_ENCRYPT				0
#define	AES_DIR_DECRYPT				1

#define	AES_MAX_BLOCK_SIZE			64
#define	AES_BLOCK_SIZE				16
#define	AES_KEY_SIZE				16
#define	AES_IV_SIZE					16

typedef struct
{
    ks_uint32 erk[64];     /* encryption round keys */
    ks_uint32 drk[64];     /* decryption round keys */
    int nr;             /* number of rounds */
}
aes_context;

#ifdef __cplusplus
extern "C" {
#endif

int		aes_set_key		( aes_context *ctx, ks_uint8 *key, int nbits );
void	aes_encrypt		( aes_context *ctx, ks_uint8 *input, ks_uint8 *output );
void	aes_decrypt		( aes_context *ctx, ks_uint8 *input, ks_uint8 *output );
int		KS_AES_CBC		(KS_BYTE *output,
						 KS_BYTE *input, KS_WORD inputLength,
						 KS_BYTE *key, KS_WORD keyLength,
						 KS_BYTE iv[16], const int dir);
//return length of result
int		KS_AES_ECB		(KS_BYTE *output,
                             KS_BYTE *input, KS_WORD inputLength,
                             KS_BYTE *key, KS_WORD keyLength,
                             const int dir);

int		_AES_CBC		(KS_BYTE *output,
						 KS_BYTE *input, KS_WORD inputLength,
						 aes_context *aes_ctx, KS_BYTE iv[16], const int dir);

#ifdef __cplusplus
} // of extern "C"
#endif

#endif /* aes.h */

