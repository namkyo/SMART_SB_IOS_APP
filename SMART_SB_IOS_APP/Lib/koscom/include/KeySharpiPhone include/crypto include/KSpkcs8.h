#ifndef __KSW_PKCS8_H__
#define __KSW_PKCS8_H__

/* 
PrivateKeyInfo ::= SEQUENCE {
	version Version,
	privateKeyAlgorithm PrivateKeyAlgorithmIdentifier,
	privateKey PrivateKey,
	attributes [0] IMPLICIT Attribytes OPTIONAL }

Version ::= INTEGER
PrivateKeyAlgorithmIdentifier ::= AlgorithmIdentifier
PrivateKey ::= OCTET STRING
Attributes ::= SET OF Attribute
*/

/*
EncryptedPrivateKeyInfo ::= SEQUENCE {
	encryptionAlgorithm		EncryptionAlgorithmIdentifier,
	encryptedData			EncryptedData }

EncryptionAlgorithmIdentifier ::= AlgorithmIdentifier
EncryptedData ::= OCTET STRING
*/

#ifdef __cplusplus
extern "C" {
#endif

int
PKCS8_PBES_Encode (unsigned char *out, int *out_len, unsigned char *in, int in_len, 
				   unsigned char *pwd, int pwd_len, unsigned char *random);

int
PKCS8_PBES2_Encode (unsigned char *out, int *out_len, unsigned char *in, int in_len, 
					unsigned char *pwd, int pwd_len, unsigned char *random, int iteration, int alg_id);

int
PKCS8_PBES_Decode (unsigned char *out, int *out_len, unsigned char *in, int in_len, 
				   unsigned char *pwd, int pwd_len);

int
PKCS8_Decode_EncPriKeyInfo (unsigned char *keyInfo, int *keyInfo_len, 
							unsigned char *encryptedPriKeyInfo, int encryptedPriKeyInfo_len, 
							unsigned char *pwd, int pwd_len);

int
PKCS8_PBES_Decode_VidRandom (unsigned char *vrandom, int *vrandom_len, 
							 unsigned char *out, int *out_len, 
							 unsigned char *in, int in_len, unsigned char *pwd, int pwd_len);

#ifdef __cplusplus
}
#endif
#endif