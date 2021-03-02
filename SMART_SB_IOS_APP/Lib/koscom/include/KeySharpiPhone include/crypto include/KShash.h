//
//  KShash.h
//  CertmanagerLibrary
//
//  Created by SuJungPark on 2015. 10. 7..
//  Copyright © 2015년 lee minsu. All rights reserved.
//

#ifndef __KSW_HASH_H__
#define __KSW_HASH_H__



#include "KSsha.h"
#include "KSsha256.h"

typedef union _shactx{
    KS_SHA_CTX sha1;
    sha256_context sha256;
}KSSHACTX;

#define HASHINIT(i, ctx)                ((i) == KS_HASH_SHA1)?KS_SHA_Init((KS_SHA_CTX*)(ctx)):sha256_starts((sha256_context*)(ctx))
#define HASHUPDATE(i, ctx, data, len)   ((i) == KS_HASH_SHA1)?KS_SHA_Update((KS_SHA_CTX*)(ctx), (data), (len)):sha256_update((sha256_context*)(ctx), (data), (len))
#define HASHFINAL(i, ctx, dout)         ((i) == KS_HASH_SHA1)?KS_SHA_Final((KS_SHA_CTX*)(ctx), (dout)):sha256_final((sha256_context*)(ctx), (dout))
#define HASH(i, dout, data, len)		((i) == KS_HASH_SHA1)?KS_SHA((dout), (data), (len)):KS_SHA2((dout), (data), (len))

#endif
