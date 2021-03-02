#ifndef __KSW_PKCS1_H_
#define __KSW_PKCS1_H_

#include "KSdefine.h"
#include "KSbigint.h"
#include "KSrand.h"
//#include "KS_prime.h"


/***
 ***	Basic Types
 ***/
typedef struct{
    BigInt		*n;		/*	modulus	*/
	BigInt		*e;		/*	publicExponent	*/
} PKCS1PublicKey;


typedef struct{
	BigInt		*n;		/*	modulus	*/
	BigInt		*e;		/*	publicExponent	*/
	BigInt		*d;		/*	privateExponent	*/
	BigInt		*p;		/*	prime1	*/
	BigInt		*q;		/*	prime2	*/
	BigInt		*dP;	/*	exponent1	*/
	BigInt		*dQ;	/*	exponent2	*/
	BigInt		*qInv;	/*	coefficient	*/
} PKCS1PrivateKey;

/***
 ***	PSS Param Types
 ***/
typedef struct {
    int			hashID;
    int			mgfID;
} PKCS1_PSS_PARAM;


#define		KS_ALGID_MD2						5
#define		KS_ALGID_MD5						7
#define		KS_ALGID_SHA1						8
#define		KS_ALGID_SHA256						9
#define		KS_ALGID_SHA384						10
#define		KS_ALGID_SHA512						11

#define     KS_MGFID_MGF1_SHA1                  1
#define     KS_MGFID_MGF1_SHA256                2

#define		DEFAULT_SIEVE_SIZE					500
#define		DEFAULT_VERSION						0

/*****
 *****
 *****		Function Prototypes
 *****
 *****/

#ifdef __cplusplus
extern "C" {
#endif

PKCS1PrivateKey	*PKCS1_PrivateKeyCreate		(void );
PKCS1PublicKey	*PKCS1_PublicKeyCreate		(void );
void			PKCS1_PrivateKeyFree		(PKCS1PrivateKey *key );
void			PKCS1_PublicKeyFree			(PKCS1PublicKey *key );
KS_WORD			PKCS1_PrivateKeyEncode		(KS_BYTE *byteSeq, PKCS1PrivateKey *key, int *resultSize );
KS_WORD			PKCS1_PrivateKeyDecode		(PKCS1PrivateKey *key, KS_BYTE *byteSeq, int seqByteLength );
KS_WORD			PKCS1_FoolishKeyDecode		(PKCS1PrivateKey *key, KS_BYTE *byteSeq, int seqByteLength );
KS_WORD			PKCS1_PublicKeyEncode		(KS_BYTE *byteSeq, PKCS1PublicKey *key, int *resultSize );
KS_WORD			PKCS1_PublicKeyDecode		(PKCS1PublicKey *key, KS_BYTE *byteSeq, int seqByteLength );
KS_WORD			PKCS1_RSAKeyGenerate		(PKCS1PrivateKey *key, PKCS1PublicKey *pKey, BigInt *publicKey, int keyByteLength );

KS_WORD			PKCS1_I2OSP					(KS_BYTE *byteSeq, BigInt *input, int seqLength );
KS_WORD			PKCS1_OS2IP					(BigInt *output, KS_BYTE *input, int byteLength );
KS_WORD			PKCS1_EME_Encode			(KS_BYTE *output, KS_BYTE *input, int outputLength, int inputLength );
KS_WORD			PKCS1_EME_Decode			(KS_BYTE *output, KS_BYTE *input, int *outputLength, int inputLength );
KS_WORD			PKCS1_EMSA_Encode			(KS_BYTE *output, KS_BYTE *input, int outputLength, int inputLength, int hashID );

KS_WORD			PKCS1_PublicKeyExp			(BigInt *output, BigInt *input, PKCS1PublicKey *key );
KS_WORD			PKCS1_PrivateKeyExp			(BigInt *output, BigInt *input, PKCS1PrivateKey *key );

KS_WORD			PKCS1_Sign					(KS_BYTE *signature, KS_BYTE *hashValue, PKCS1PrivateKey *key, int hashID );
KS_WORD         PKCS1_PSS_Sign              (KS_BYTE *signature, KS_WORD *signatureLength, KS_BYTE *hash, KS_WORD hashLength, PKCS1PrivateKey *privKey, PKCS1_PSS_PARAM *pssParam);
KS_WORD			PKCS1_Verify				(KS_BYTE *signature, KS_BYTE *hashValue, PKCS1PublicKey *key, int hashID, int signLength );
KS_WORD			PKCS1_Verify_Koscom				(KS_BYTE *signature, KS_BYTE *hashValue, PKCS1PublicKey *key, int hashID, int signLength );

KS_WORD			PKCS1_EME_Encrypt			(KS_BYTE *cipher, KS_BYTE *plain, PKCS1PublicKey *key, int plainLength );
KS_WORD			PKCS1_EME_Decrypt			(KS_BYTE *plain, KS_BYTE *cipher, PKCS1PrivateKey *key, int *plainLength, int cipherLength );

//for koscom
KS_WORD			PKCS1_Sign_Koscom			(KS_BYTE *signature, KS_BYTE *hashValue, PKCS1PrivateKey *key, int hashID );
KS_WORD			PKCS1_EMSA_Encode_Koscom	(KS_BYTE *output, KS_BYTE *input, int outputLength, int inputLength, int hashID );

	
int				Pubkey_Copy(PKCS1PublicKey *dest, PKCS1PublicKey *src);
int				Prikey_Copy(PKCS1PrivateKey *dest, PKCS1PrivateKey *src);

#ifdef __cplusplus
} // of extern "C"
#endif

/*****
 *****
 *****		PKCS#1	Error Message
 *****
 *****/

#define		PKCS1_ERROR											0x80020000L
#define		PKCS1_INVALID_INPUT									(PKCS1_ERROR + INVALID_INPUT )
#define		PKCS1_MALLOC_FAILURE								(PKCS1_ERROR + 1 )
#define		PKCS1_INTEGER_TOO_LARGE								(PKCS1_ERROR + 2 )
#define		PKCS1_MESSAGE_TOO_LONG								(PKCS1_ERROR + 3 )
#define		PKCS1_DECODING_ERROR								(PKCS1_ERROR + 4 )
#define		PKCS1_INTENDED_ENCODED_MESSAGE_LENGTH_TOO_SHORT		(PKCS1_ERROR + 5 )
#define		PKCS1_MESSAGE_OUT_OF_RANGE							(PKCS1_ERROR + 6 )
#define		PKCS1_CIPHERTEXT_REPRESENTATIVE_OUT_OF_RANGE		(PKCS1_ERROR + 7 )
#define		PKCS1_INVALID_SIGNATURE								(PKCS1_ERROR + 8 )
#define		PKCS1_DECRYPT_ERROR									(PKCS1_ERROR + 9 )
#define		PKCS1_WRONG_KEY_TYPE								(PKCS1_ERROR + 10 )
#define     PKCS1_ENCODING_ERROR                                (PKCS1_ERROR + 11 )


#endif
