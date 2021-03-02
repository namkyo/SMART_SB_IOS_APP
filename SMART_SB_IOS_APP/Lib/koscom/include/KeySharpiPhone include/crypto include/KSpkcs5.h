#ifndef __KSW_PKCS5_H__
#define __KSW_PKCS5_H__

#define PKCS5OID_PBEWithSHA1And3KeyTDES		3
#define PKCS5OID_PBEWithSHA1AndSEED			4		/* KSIGN */
#define PKCS5OID_PBEWithSHA1AndSEED1		15

#define PKCS5OID_PBES2				13
#define PKCS5OID_PBEWith3KeyTDES	7

#define PKCS5OID_PKCS12KDF				12
#define PKCS5OID_PBEWithSHA1AndARIA		    20		



#ifdef __cplusplus
extern "C" {
#endif

int 
PKCS5_PBES_Encrypt (unsigned char *out, int *out_len, unsigned char *in, int in_len, 
					unsigned char *pwd, int pwd_len, unsigned char *salt, 
					int iteration, int alg_id);

int
PKCS5_PBES_Decrypt (unsigned char *out, int *out_len, unsigned char *in, int in_len, 
					unsigned char *pwd, int pwd_len, unsigned char *salt, int salt_len,
					int iteration, int alg_id);

int 
PKCS5_PBES2_Encrypt (unsigned char *out, int *out_len, unsigned char *in, int in_len, 
					 unsigned char *pwd, int pwd_len, unsigned char *salt, int salt_len, 
					 int iteration, int alg_id, unsigned char *iv, int ivLen);

int 
PKCS5_PBES2_Decrypt (unsigned char *out, int *out_len, unsigned char *in, int in_len, 
					 unsigned char *pwd, int pwd_len, unsigned char *salt, int salt_len, 
					 int iteration, int alg_id, unsigned char *iv, int ivLen);

int PKCS5_PBKDF2 (unsigned char *key, int key_len, unsigned char *pwd, int pwd_len, unsigned char *salt, int salt_len, int iteration);
    
#ifdef __cplusplus
}
#endif

#endif