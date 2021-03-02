#ifndef __KSW_PROTOCOL_H__
#define __KSW_PROTOCOL_H__

/* size */
#define	KEY_BLOCK_SIZE		(SEED_IV_SIZE + SEED_KEY_SIZE + SHA_DIGEST_LENGTH) * 2

#define	SESSION_ID_SIZE		20
#define	RANDOM_SIZE			20
#define	SECRET_SIZE			48
#define	MASTER_KEY_SIZE		20

#define RANDOM_SEED_MAX     20


/* version */
#define KSW1_PROTOCOL_VERSION_MAJOR      0x02
#define KSW1_PROTOCOL_VERSION_MINOR      0x04
#define KSW1_SERVER_VERSION_MAJOR        0x02
#define KSW1_SERVER_VERSION_MINOR        0x00
#define KSW1_CLIENT_VERSION_MAJOR        0x02
#define KSW1_CLIENT_VERSION_MINOR        0x00

/* profile */
#define KSX2_RSAE_NULL_WITH_AES_SHA1_NULL       0x011100    /* default but not use in korea */
#define KSX2_RSAE_NULL_WITH_AES_MD5_NULL        0x011200
#define KSX2_RSAE_NULL_WITH_SEED_SHA1_NULL      0x012100    /* use */
#define KSX2_RSAE_NULL_WITH_SEED_SHA1_ZLIB      0x012101    /* use */
#define KSX2_RSAE_NULL_WITH_SEED_MD5_NULL       0x012200
#define KSX2_RSAE_NULL_WITH_3DES_SHA1_NULL      0x013100
#define KSX2_RSAE_NULL_WITH_3DES_MD5_NULL       0x013200
#define KSX2_RSAE_RSAS_WITH_AES_SHA1_NULL       0x021100
#define KSX2_RSAE_RSAS_WITH_AES_MD5_NULL        0x021200
#define KSX2_RSAE_RSAS_WITH_SEED_SHA1_NULL      0x022100
#define KSX2_RSAE_RSAS_WITH_SEED_MD5_NULL       0x022200
#define KSX2_RSAE_RSAS_WITH_3DES_SHA1_NULL      0x023100
#define KSX2_RSAE_RSAS_WITH_3DES_MD5_NULL       0x023200

/* seperated profile : appended */
#define KSX2_RSAE_NULL      0x01
#define KSX2_RSAE_RSAS      0x02

#define KSX2_AES_SHA1       0x11
#define KSX2_AES_MD5        0x12
#define KSX2_SEED_SHA1      0x21
#define KSX2_SEED_MD5       0x22
#define KSX2_SEED_CBCMAC    0x23	/* update : 2003.4.27 */
#define KSX2_3DES_SHA1      0x31
#define KSX2_3DES_MD5       0x32

#define KSX2_COMPRESS_NULL  0x00
#define KSX2_COMPRESS_ZLIP  0x01


/*
enum {
    KEYINIT(1), KEYFINAL(2), MESSAGE(3), ALERT(4),
    NEW_PROFILE(10), 
    RESUME_INIT(20), RESUME_FINAL(21), NO_KEY(22),
    SESSION_CLOSE(100), MASTER_SESSION_CLOSE(100), (255)
} ContentType;
*/
#define	KSW1_CT_KEYINIT					1
#define	KSW1_CT_KEYFINAL					2
#define	KSW1_CT_MESSAGE					3
#define	KSW1_CT_ALERT					4
#define	KSW1_CT_NEW_PROFILE				10
#define	KSW1_CT_RESUME_INIT				20
#define	KSW1_CT_RESUME_FINAL				21
#define	KSW1_CT_NO_KEY					22
#define	KSW1_CT_SESSION_CLOSE			100
#define	KSW1_CT_MASTER_SESSION_CLOSE		101

/**************************************************************
enum {
	cert (1) , auth_type(2) , both(3),  (255)
} UpdateType ;
***************************************************************/
#define	KS_UT_CERT			1
#define	KS_UT_AUTH_TYPE		2
#define	KS_UT_BOTH			3

#endif
