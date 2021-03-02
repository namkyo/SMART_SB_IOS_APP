
#ifndef	__KSW_PHASH_H__
#define	__KSW_PHASH_H__

#ifdef  __cplusplus
extern "C" {
#endif

/**
 *	KS_PHASH :
 *
 *	output : output			: pointer to output buffer
 *	input  : output_len		: length of output
 *			 secret			: pointer to secret
 *			 secret_len		: length of secret
 *			 seed			: pointer to secret
 *			 seed_len		: length of secret
 *
 */
void KS_PHASH			(ks_uint8 *output, int output_len, ks_uint8 *secret, int secret_len, ks_uint8 *seed, int seed_len);

#ifdef  __cplusplus
}
#endif

#endif
