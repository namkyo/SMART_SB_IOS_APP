

#ifndef __KSW_RAND_H__
#define __KSW_RAND_H__

#include "KSdefine.h"

typedef struct{
	KS_WORD		lfsrA[9];
	KS_WORD		lfsrB[9];
} LfsrContext;

#ifdef  __cplusplus
extern "C" {
#endif

void RAND_Init1		(void);
void RAND_GetByte	(KS_BYTE *random, int byte_len);

LfsrContext *Lfsr_ContextCreate	(void );
void		Lfsr_ContextFree	(LfsrContext *pContext );

KS_WORD		Lfsr_Engine			(LfsrContext *pContext );
void		Lfsr_Init			(LfsrContext *pContext );
void		Lfsr_ByteSeq		(KS_BYTE *randSeq,	int seqSize );

#ifdef	__cplusplus
}
#endif

#endif
