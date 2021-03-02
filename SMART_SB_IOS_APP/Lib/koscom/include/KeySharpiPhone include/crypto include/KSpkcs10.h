
#ifndef __KSW_PKCS10_H__
#define __KSW_PKCS10_H__

#define PKCS10_KEYSIZE_BIT		10

/* Subject oid type */
#define SUBJECTOID_CN		1
#define SUBJECTOID_C		2
#define SUBJECTOID_L		3
#define SUBJECTOID_ST		4
#define SUBJECTOID_O		5
#define SUBJECTOID_OU		6

/* Error Code */
#define PKCS10ERR							1500

#define _ERR_PKCS10_KEYGENERATE_FAIL		-(PKCS10ERR+1)
#define _ERR_PKCS10_PUBKEYENCODE_FAIL		-(PKCS10ERR+2)
#define _ERR_PKCS10_PRIKEYENCODE_FAIL		-(PKCS10ERR+3)
#define _ERR_PKCS10_INVALID_OPTVAL			-(PKCS10ERR+4)
#define _ERR_PKCS10_PRIKEYDECODE_FAIL		-(PKCS10ERR+5)
#define _ERR_PKCS10_SIGN_FAIL				-(PKCS10ERR+6)
#define _ERR_PKCS10_MALLOC_FAIL				-(PKCS10ERR+7)
#define _ERR_PKCS10_OID_NOT_EXIST			-(PKCS10ERR+8)
#define _ERR_PKCS10_INVALID_INPUT			-(PKCS10ERR+9)
#define _ERR_PKCS10_NOT_SUPPORTED_OID		-(PKCS10ERR+10)
#define _ERR_PKCS10_WRONG_KEYSIZE           -(PKCS10ERR+11)


typedef struct {
	/* Keys */
	unsigned char	pubkey[1024];
	int				pubkey_len;
	unsigned char	prikey[2048];
	int				prikey_len;
	char			passwd[32];

	/* subject */
	char	c[8];
	char	st[512];
	char	l[32];
	char	o[32];
	char	ou[64];
	char	cn[120];

	/* idn and vid random */
	unsigned char	random[20];

} PKCS10_CTX;

typedef struct {
	int		key_size;	/* byte */

} PKCS10_Option;

#ifdef  __cplusplus
extern "C" {
#endif

int
PKCS10_CertReq(ks_uint8 *out, int *out_len, ks_uint8 *key, int *key_len, char *c, char *st, char *l, char *o, char *ou, char *cn, int key_size);
int
PKCS10_Get_SubjectType(ks_uint8 *out, int subject_type, ks_uint8 *cert, int cert_len);
int
KS_KVP_EncCardPW (KS_BYTE *outEncPasswd, /*[out] encrypted password*/
				  KS_BYTE *outWK_key, 	 /*[out] working key*/
				  const KS_BYTE *inCardno, 
				  const KS_BYTE *inPasswd, 
				  const KS_BYTE *inMkey );

#ifdef  __cplusplus
}
#endif

#endif
