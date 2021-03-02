
#ifndef __KSW_DEFINE_H__
#define __KSW_DEFINE_H__

#define		ENCALGID_DES		0
#define		ENCALGID_3DES		1
#define		ENCALGID_SEED		10
#define		ENCALGID_AES		12

#define		PENCALGID_RSA		1
#define		PENCALGID_RSA_OAEP	5

#define     MASK08				(0xffL)				//  8 bit mask
#define     MASK16				(0xffffL)			// 16 bit mask
#define     MASK32				(0xffffffffL)		// 32 bit mask
#define		MASKMSB				(0x80000000L)		// MSB of KS_WORD
#define     WORD_BITLENGTH		32					// bit  length of KS_WORD
#define     WORD_BYTELENGTH		4					// byte length of KS_WORD

#define		ks_uint8				unsigned char
#define		ks_uint16				unsigned short
#define		ks_uint32				unsigned int
#define		int32				int

typedef		unsigned char		KS_BOOL;				
typedef		unsigned char		KS_BYTE;				
typedef		unsigned int		KS_WORD;				

#define		KS_ALGID_MD2					5
#define		KS_ALGID_MD5					7
#define		KS_ALGID_SHA1					8
#define		KS_ALGID_SHA256					9
#define		KS_ALGID_HMACSHA				10


#ifndef true
#define		true				1
#endif
#ifndef false
#define		false				0
#endif

#endif
