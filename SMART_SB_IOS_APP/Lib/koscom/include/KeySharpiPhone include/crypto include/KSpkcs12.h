#ifndef	__KSW_PKCS12_H__
#define	__KSW_PKCS12_H__

#define CONTENTTYPE_DATA			0x01
#define CONTENTTYPE_ENCRYPTEDDATA	0x06

#define SAFEBAG_PKCS8SHROUDEDKEY	0x10
#define SAFEBAG_CERT				0x11

#ifdef __cplusplus
extern "C" {
#endif

int
PKCS12_PFX_Encode (unsigned char *out, int *out_len, 
				   unsigned char *prikey, int prikey_len,		/* EncryptedPrivateKeyInfo */
				   unsigned char *cert, int cert_len,
				   unsigned char *pwd, int pwd_len);

int
PKCS12_PFX_Decode (unsigned char *prikey, int *prikey_len,		/* out : pkcs#8 private key */
				   unsigned char *cert, int *cert_len,			/* out */
				   unsigned char *in, int in_len,
				   unsigned char *pwd, int pwd_len);

#ifdef __cplusplus
}
#endif

#endif
