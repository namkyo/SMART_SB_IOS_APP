#ifndef __KS_SHA256_H__
#define __KS_SHA256_H__

//sjpark
#define KS_HASH_SHA256		200

typedef struct
{
    unsigned int total[2];
    unsigned int state[8];
    unsigned char buffer[64];
}
sha256_context;

void sha256_starts( sha256_context *ctx );
void sha256_update( sha256_context *ctx, unsigned char *input, unsigned int length );
void sha256_final( sha256_context *ctx, unsigned char digest[32] );
void sha256_process( sha256_context *ctx, unsigned char data[64] );
void KS_SHA2(unsigned char *out, unsigned char *in, int inbytes);

#endif /* sha256.h */
