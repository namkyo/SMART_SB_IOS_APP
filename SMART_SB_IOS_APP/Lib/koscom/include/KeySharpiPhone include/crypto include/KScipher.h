
#ifndef __KSW_CIPHER_H__
#define __KSW_CIPHER_H__

typedef struct _KS_CIPHER_CTX {
	KS_BYTE *roundKey;
	KS_BYTE iv[16];
	KS_BYTE dreg[16];
	KS_WORD dregSize;
	KS_WORD blockSize;
	KS_WORD roundKeySize;
	KS_WORD alg;	/* ENCALGID_DES, ENCALGID_3DES, ENCALGID_SEED, ENCALGID_AES */
	KS_WORD dir;	/* 0 : encrypt 1 : decrypt */
} KS_CIPHER_CTX;

#ifdef __cplusplus
extern "C" {
#endif

int KS_DES_CBC_MAC (
					KS_BYTE *out			/* [out] */,
					KS_BYTE *in				/* [in] */,
					const KS_WORD in_len	/* [in] */,
					KS_BYTE *key			/* [in] */,
					KS_BYTE *iv				/* [in/out] */
					);

void * KS_CIPHER_INIT
					(
					KS_BYTE *key,
					KS_WORD keyLength,
					KS_BYTE *iv,
					KS_WORD alg,
					KS_WORD dir
					);

int KS_CIPHER_UPDATE(
					 KS_CIPHER_CTX *ctx,
					 KS_BYTE *pOut,
					 KS_WORD *outLength,
					 KS_BYTE *pIn,
					 KS_WORD inLength
					 );

int KS_CIPHER_FINAL (
					 KS_CIPHER_CTX *ctx,
					 KS_BYTE *pOut,
					 KS_WORD *outLength
					);

#ifdef __cplusplus
}
#endif

#endif
