//
//	KS_oid.h
//

#ifndef __KSW_OID_H__
#define __KSW_OID_H__

/**
 *
 *		CMS OID
 *
 */

//	id-data OBJECT IDENTIFIER ::= { iso(1) member-body(2)
//         us(840) rsadsi(113549) pkcs(1) pkcs7(7) 1 
//}
extern unsigned char	oid_id_data[];
extern int				oid_id_data_length;

//	id_contentType OBJECT IDENTIFIER ::= { iso(1) member-body(2)
//         us(840) rsadsi(113549) pkcs(1) pkcs9(9) 3
//}
extern unsigned char	oid_id_contentType[];
extern int				oid_id_contentType_length;

//	id-messageDigest OBJECT IDENTIFIER ::= { iso(1) member-body(2)
//         us(840) rsadsi(113549) pkcs(1) pkcs9(9) 4 }
//}
extern unsigned char	oid_id_messageDigest[];
extern int				oid_id_messageDigest_length;

//	id-signingTime OBJECT IDENTIFIER ::= { iso(1) member-body(2)
//         us(840) rsadsi(113549) pkcs(1) pkcs9(9) 5
//}
extern unsigned char	oid_id_signingTime[];
extern int				oid_id_signingTime_length;


/**
 *
 *		DigestAlgorithm OID
 *
 */

//	md5 OBJECT IDENTIFIER ::= { 
//			iso(1) member-body(2) us(840) rsadsi(113549) digestAlgorithm(2) 5 
//	}
extern unsigned char	oid_md5[];
extern int				oid_md5_length;

//	sha-1 OBJECT IDENTIFIER ::= { iso(1) identified-organization(3)
//    oiw(14) secsig(3) algorithm(2) 26
//	}
extern unsigned char	oid_sha_1[];
extern int				oid_sha_1_length;

/**
 *
 *		Content Encryption Algorithm OID
 *
 */

//	des-ede3-cbc OBJECT IDENTIFIER ::= { iso(1) member-body(2)
//          us(840) rsadsi(113549) encryptionAlgorithm(3) 7
//	}
extern unsigned char oid_des_ede3_cbc[];
extern int				oid_des_ede3_cbc_length;


//	rc2-cbc OBJECT IDENTIFIER ::= { iso(1) member-body(2) us(840)
//			rsadsi(113549) encryptionAlgorithm(3) 2 
//}
extern unsigned char oid_rc2_cbc[];
extern int				oid_rc2_cbc_length;


//	seedCBC	OBJECT IDENTIFIER	::=	{ 1 2 410 200004 1 4 }
extern unsigned char oid_seedCBC[];
extern int				oid_seedCBC_length;


//  aes OBJECT IDENTIFIER ::= { joint-iso-itu-t(2) country(16) us(840) 
//		organization(1) gov(101) csor(3) nistAlgorithm(4) 1 
//}
extern unsigned char oid_aes[];
extern int				oid_aes_length;

/**
 *
 *		Signature Algorithm	 OID
 *
 */

//	md5WithRSAEncryption OBJECT IDENTIFIER  ::=  {
//			iso(1) member-body(2) us(840) rsadsi(113549) pkcs(1) pkcs-1(1) 4  
//	}
extern unsigned char	oid_md5WithRSAEncryption[];
extern int				oid_md5WithRSAEncryption_length; /* 2005-05-16 extern √ﬂ∞° */

//	sha-1WithRSAEncryption OBJECT IDENTIFIER  ::=  {
//			iso(1) member-body(2) us(840) rsadsi(113549) pkcs(1) pkcs-1(1) 5  
//	}
extern unsigned char	oid_sha1WithRSAEncryption[];
extern int				oid_sha1WithRSAEncryption_length;

extern unsigned char	oid_sha256WithRSAEncryption[];
extern int				oid_sha256WithRSAEncryption_length;
/**
 *
 *		X.509
 *
 */

// DN

//	id-at-commonName	AttributeType ::= { id-at 3 }
//
extern unsigned char	oid_commonName[];
extern int				oid_commonName_length;

//	id-at-serialNumber	AttributeType ::= { id-at 3 }
//
extern unsigned char	oid_serialNumber[];
extern int				oid_serialNumber_length;

//	id-at-countryName	AttributeType ::= { id-at 6 }
//
extern unsigned char	oid_countryName[];
extern int				oid_countryName_length;

//	id-at-localityName	AttributeType ::= { id-at 7 }
//
extern unsigned char	oid_localityName[];
extern int				oid_localityName_length;

//	id-at-stateOrProvinceName	AttributeType ::= { id-at 8 }
//
extern unsigned char	oid_stateOrProvinceName[];
extern int				oid_stateOrProvinceName_length;

//	id-at-organizationName	AttributeType ::= { id-at 10 }
//
extern unsigned char	oid_streetAddress[];
extern int				oid_streetAddress_length;

//	id-at-organizationName	AttributeType ::= { id-at 10 }
//
extern unsigned char	oid_organizationName[];
extern int				oid_organizationName_length;

//	id-at-organizationUnitName	AttributeType ::= { id-at 11 }
//
extern unsigned char	oid_organizationUnitName[];
extern int				oid_organizationUnitName_length;

//	id-at-title	AttributeType ::= { id-at 12 }
//
extern unsigned char	oid_title[];
extern int				oid_title_length;

extern unsigned char	oid_dnQualifier[];
extern int				oid_dnQualifier_length;

extern unsigned char	oid_domainComponent[];
extern int				oid_domainComponent_length;

extern unsigned char	oid_emailAddress[];
extern int				oid_emailAddress_length;

// Extention

//  id-ce-subjectAltName OBJECT IDENTIFIER ::=  { id-ce 17 }
//
extern unsigned char	oid_id_ce_subjectAltName[];
extern int				oid_id_ce_subjectAltName_length;

//  id-ce-policyConstraints OBJECT IDENTIFIER ::=  { id-ce 36 }
//
extern unsigned char	oid_id_ce_policyConstraints[];
extern int				oid_id_ce_policyConstraints_length;

//Certificate Usages added by choi 2012.04.02
extern unsigned char	oid_id_certificateUsage[];
extern int				oid_id_certificateUsage_length;

//Certificate User Notice added by pol808 2018.11.30
extern unsigned char    oid_id_certificateUserNotice[];
extern int              oid_id_certificateUserNotice_length;

// SIM

//  id-kisa-identifyData OBJECT IDENTIFIER  ::=  { id-attribute 1 }
extern unsigned char	oid_id_kisa_identifyData[];
extern int				oid_id_kisa_identifyData_length;


//  id-VID OBJECT IDENTIFIER ::= { id-kisa-identifyData 1 }
extern unsigned char	oid_id_VID[];
extern int				oid_id_VID_length;


// Policy OID

// YesSign

//

//Certificate Policies added by solarsun 2005 08/14
//  id-ce-certificatePolicies OBJECT IDENTIFIER ::= { id-ce 32 }
extern unsigned char	oid_id_certificatePolicies[];
extern int				oid_id_certificatePolicies_length;

//Certificate Usages added by choi 2012.04.02
extern unsigned char	oid_id_certificateCRLDistributionPoint[];
extern int				oid_id_certificateCRLDistributionPoint_length;


// Certificate Policies added by solarsun 2005 08/16
#define MAX_CERTIFICATE_POLICY_LEN 43
typedef struct _POLICY_OBJECT_ID {
    unsigned short  length;
    unsigned char   *value;
	char * dotValue;
} PolicyObjectID;

typedef struct _CertPolicy {
	PolicyObjectID objectID[MAX_CERTIFICATE_POLICY_LEN];

} CertPolicy;

//extern CertPolicy certPolicy;

extern unsigned char pkcs7oid_Data[11];
extern unsigned char pkcs7oid_signedData[11];
extern unsigned char pkcs7oid_envelopedData[11];
extern unsigned char signedAttrTmpt[0x5F];
extern unsigned char signedAttrTmpt_sha256[0x6B];
extern unsigned char digestAlgorithm_sha1[0x0B];
extern unsigned char digestAlgorithm_sha256[0x0F];

extern unsigned char rsaEncryptionCms[0x0F];
#define RSA_OID_LENGTH 0x0F

extern unsigned char rsaEncryptionOid[0x0D];

extern unsigned char kcdsaOid[0x0C];
extern unsigned char KS_seedCBC[0x0A];
#define SEEDCBC_OID_LENGTH 0x0A

extern unsigned char aesCBC[0x0A];
#define AESCBC_OID_LENGTH 0x0A
extern unsigned char KS_des_EDE3_CBC[0x0A];
#define DESEDE3CBC_OID_LENGTH 0x0A

extern unsigned char KS_desCBC[0x07];
#define DESCBC_OID_LENGTH 0x07

extern unsigned char ariaCBC[0x0A];

#define DATA_OID_LENGTH 0x0B

#endif
