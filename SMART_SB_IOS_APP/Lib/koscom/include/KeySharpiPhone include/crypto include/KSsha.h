
#ifndef __KSW_SHA_H__
#define __KSW_SHA_H__

#include "KSdefine.h"

#define KS_SHA_CBLOCK				64
#define	SHA_DIGEST_LENGTH		20
#define	SHA256_DIGEST_LENGTH	32

//sjpark
#define KS_HASH_SHA1		100


typedef struct {
	KS_WORD		state[5];
	KS_WORD		count[2];
	KS_BYTE		buffer[64];
} KS_SHA_CTX;

#ifdef __cplusplus
extern "C" {
#endif

void KS_SHA_Init		(KS_SHA_CTX *ctx);
void KS_SHA_Update		(KS_SHA_CTX *ctx, KS_BYTE *data, KS_WORD len);
void KS_SHA_Final		(KS_SHA_CTX *ctx, KS_BYTE *md);

void KS_SHA			(KS_BYTE *md, KS_BYTE *data, KS_WORD len);

#ifdef __cplusplus
}
#endif


#endif
