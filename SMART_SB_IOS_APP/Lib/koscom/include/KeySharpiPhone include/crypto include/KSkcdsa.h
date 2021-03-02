//
//	ks_kcdsa.h
//

#ifndef __KSW_KDSA_H__
#define __KSW_KDSA_H__

#include "KSbigint.h"


#define KS_KCDSA_HASHID_SHA1		100   //KS_HASH_SHA1
#define KS_KCDSA_HASHID_SHA256	    200   //KS_HASH_SHA256

/**
 *	Struct
 */

typedef struct {
	BigInt		*p;			// prime modulus p = 2jq+1
	BigInt		*q;			// prime divisor of p-1
	BigInt		*g;			// base (generator)
	
	BigInt		*j;			// subgroup factor (optional)
	struct {
		KS_BYTE		*seed;		// 160/8 ~ 256/8 bytes
		KS_WORD		seedLength;
		BigInt	*counter;
	} validation;				// (optional)
} _KS_KCDSA_Parameters;

typedef struct {
	KS_BYTE		r[32];
	KS_WORD		rLength;
	BigInt		*s;
} _KS_KCDSA_Signature;



/**
 *	Prototypes
 */

#ifdef __cplusplus
extern "C" {
#endif

_KS_KCDSA_Parameters *
			_KS_KCDSA_Parameters_New			(void);

void		KS_KCDSA_Parameters_Free		(_KS_KCDSA_Parameters *params);

_KS_KCDSA_Signature *
			_KS_KCDSA_Signature_New			(void);

void		KS_KCDSA_Signature_Free			(_KS_KCDSA_Signature *signature);

int	KS_KCDSA_GenerateParameters		(_KS_KCDSA_Parameters *params,
											  KS_WORD primeByteLength);

int	_KS_KCDSA_VerifyParameters		( _KS_KCDSA_Parameters *params, KS_WORD hashID);


int	KS_KCDSA_GenerateKey			(BigInt *privKey, 
											 BigInt *pubKey,
											  _KS_KCDSA_Parameters *params);

int	_KS_KCDSA_VerifyPublicKey		( BigInt *pubKey,
											  _KS_KCDSA_Parameters *params);

int	_KS_KCDSA_ProveKeyPair			( BigInt *privKey,
											  BigInt *pubKey,
											  _KS_KCDSA_Parameters *params);

int	_KS_KCDSA_Hash					(KS_BYTE *hash,
											 KS_WORD *hashLength,
											  KS_BYTE *message,
											  KS_WORD messageLength,
											  int hashID,
											  BigInt *pubKey);

int	_KS_KCDSA_Sign					(_KS_KCDSA_Signature *signature,
											  int hashID,
											  KS_BYTE *hash, 
											  KS_WORD hashLength,
											  _KS_KCDSA_Parameters *params,
											  BigInt *privKey);

int	_KS_KCDSA_Verify					( _KS_KCDSA_Signature *signature,
											  int hashID,
											  KS_BYTE *hash, 
											  KS_WORD hashLength,
											  _KS_KCDSA_Parameters *params,
											  BigInt *pubKey);

// asn.1

int	_KS_KCDSA_Parameters_Encode		(KS_BYTE *output,
											 KS_WORD *outputLength,
											  _KS_KCDSA_Parameters *params);

int	_KS_KCDSA_Parameters_Decode		(_KS_KCDSA_Parameters *params,
											  KS_BYTE *input, 
											  KS_WORD inputLength);

int	_KS_KCDSA_Signature_Encode		(KS_BYTE *output,
											 KS_WORD *outputLength,
											  _KS_KCDSA_Signature *signature);

int	_KS_KCDSA_Signature_Decode		(_KS_KCDSA_Signature *signature,
											  KS_BYTE *input, 
											  KS_WORD inputLength);

int	_KS_KCDSA_PublicKey_Encode		(KS_BYTE *output,
											 KS_WORD *outputLength,
											  BigInt *pubKey);

int	_KS_KCDSA_PublicKey_Decode		(BigInt *pubKey,
											  KS_BYTE *input, 
											  KS_WORD inputLength);

#ifdef __cplusplus
}
#endif

#endif
