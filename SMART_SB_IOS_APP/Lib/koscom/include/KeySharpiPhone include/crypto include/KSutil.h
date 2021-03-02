
#ifndef __KSW_UTIL_H__
#define __KSW_UTIL_H__

#include <stdlib.h>
#include "KSdefine.h"

//encoding type
#define KSH_ENCODING_BINARY 1
#define KSH_ENCODING_BASE64 2
#define KSH_ENCODING_HEXUP  3
#define KSH_ENCODING_HEXLOW 4


#ifdef __cplusplus
extern "C" {
#endif
int hexencode(ks_uint8** out, ks_uint8* in, int inLen, int mode); //mode1: upper, mode0: lower
int hexdecode(ks_uint8** out, ks_uint8* buf, int inlen);
void hexfree(ks_uint8** pp);

int KSH_Msg_Encoding(ks_uint8* output , ks_uint8*input , ks_uint32 inputLen , int encodingFlag);
int KSH_Msg_Decoding(ks_uint8* output , ks_uint8*input , ks_uint32 inputLen , int decodingFlag);

#ifdef __cplusplus
}
#endif

#endif
