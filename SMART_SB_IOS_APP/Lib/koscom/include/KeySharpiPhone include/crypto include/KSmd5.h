#ifndef __KSW_MD5_H__
#define __KSW_MD5_H__

#include "KSdefine.h"

typedef struct {
	KS_WORD		hashID;
	KS_BYTE		hashValueSize;
	KS_WORD		state[5];
	KS_WORD		count[2];
	KS_BYTE		buffer[64];
} HashContext;

#define MD5_DIGEST_LENGTH 16

/* ===============
 *    Macros
 * ===============
 */
#define rotl16(x, n)	( ( (x) << (n) ) | ( (x) >> (16 - (n) ) ) )
#define rotr16(x, n)	( ( (x) >> (n) ) | ( (x) << (16 - (n) ) ) )
#define rotl32(x, y)	( ( (x) << (y) ) | ( (x) >> (32 - (y) ) ) )
#define rotr32(x, y)	( ( (x) >> (y) ) | ( (x) << (32 - (y) ) ) )

/*****
 *****		Macro
 *****/

#define MD5_F(x, y, z)	(((x) & (y)) | ((~x) & (z)))
#define MD5_G(x, y, z)	(((x) & (z)) | ((y) & (~z)))
#define MD5_H(x, y, z)	((x) ^ (y) ^ (z))
#define MD5_I(x, y, z)	((y) ^ ((x) | (~z)))

#define MD5_FF(a, b, c, d, x, s, ac) {						\
	(a) += MD5_F( (b), (c), (d) ) + (x) + (KS_WORD)(ac);	\
	(a) = (rotl32((a) & MASK32, (s)) + (b)) & MASK32;		\
}
#define MD5_GG(a, b, c, d, x, s, ac) {						\
	(a) += MD5_G( (b), (c), (d) ) + (x) + (KS_WORD)(ac);	\
	(a) = (rotl32((a) & MASK32, (s)) + (b)) & MASK32;		\
}
#define MD5_HH(a, b, c, d, x, s, ac) {						\
	(a) += MD5_H( (b), (c), (d) ) + (x) + (KS_WORD)(ac);	\
	(a) = (rotl32((a) & MASK32, (s))+(b)) & MASK32;			\
}
#define MD5_II(a, b, c, d, x, s, ac) {						\
	(a) += MD5_I( (b), (c), (d) ) + (x) + (KS_WORD)(ac);	\
	(a) = (rotl32((a) & MASK32, (s))+(b)) & MASK32;			\
}


/*****
 *****		Function ProtoTypes
 *****/

#ifdef __cplusplus
extern "C" {
#endif


void	Md5Init			(HashContext *pContext );
void	Md5Update		(HashContext *pContext, KS_BYTE *input, KS_WORD inputByteLength );
void	Md5UpdateMac	(HashContext *pContext, KS_WORD *kConst, KS_BYTE *input, KS_WORD inputByteLength );
void	Md5Final		(HashContext *pContext, KS_BYTE *hashValue );

void	Md5Transform	(KS_WORD *state, KS_BYTE *input );
void	Md5MacTransform	(KS_WORD *state, KS_WORD *kConst, KS_BYTE *input );

KS_WORD	KS_Md5			(KS_BYTE *hashValue, KS_BYTE *input, KS_WORD inputByteLength );

#ifdef __cplusplus
} // of extern "C"
#endif

#endif
