//
//	KS_x509.h
//

#ifndef __KSW_X509_H__
#define __KSW_X509_H__

// CRYPTO_LIB {{
#include "KSpkcs1.h"
// }}

#include "KSasntypes.h"
#include "KSclient.h"

#ifdef	__cplusplus
extern "C" {
#endif

//added by choi 201003
#define	X509_ERR_FILE_MANAGER			-51
#define	X509_ERR_FILE_OPEN_FAILED		-52
#define	X509_ERR_MALLOC_FAIL			-53
#define	X509_ERR_INVALID_INPUT			-54
#define	X509_ERR_RSAKEY_TOO_LARGE		-55
#define	X509_ERR_UNSUPPORTED_CERT		-56
#define	X509_ERR_DECODE_ERROR			-57
#define	X509_ERR_BUFFER_OVERFLOW		-58
#define	X509_ERR_CA_CERT_NOT_FOUND		-59

// 20140102 sjyang - for chain verify
#define X509_ERR_SERVERCERT_EXPIRED     -71
#define X509_ERR_CACERT_EXPIRED         -72
#define X509_ERR_SERVERCERT_UPDATE      -73
//
//	Version
//
typedef INTEGER Version;

Version 	*KS_BIN_To_Version					(BIN *bin);
void		KS_Version_Free 					(Version *version);

//
//	CertificateSerialNumber
//
typedef INTEGER CertificateSerialNumber;

CertificateSerialNumber 
			*KS_BIN_To_CertificateSerialNumber	(BIN *bin);
void		KS_CertificateSerialNumber_Free 	(CertificateSerialNumber *certificateSerialNumber);

//
//	Validity
//
typedef struct _Validity {
	Time	*notBefore;
	Time	*notAfter;
} Validity;

Validity	*KS_BIN_To_Validity 				(BIN *bin);
void		KS_Validity_Free					(Validity *validity);

//
//	AttributeType
//
typedef OBJECT_IDENTIFIER	AttributeType;

AttributeType	*KS_BIN_To_AttributeType		(BIN *bin);
void		KS_AttributeType_Free				(AttributeType *attributeType);

//
//	AttributeValue
//
typedef ASN_ANY 			AttributeValue;

AttributeValue *KS_BIN_To_AttributeValue		(BIN *bin);
void		KS_AttributeValue_Free				(AttributeValue *attributeValue);

//
//	AttributeTypeAndValue
//
typedef struct _AttributeTypeAndValue {
	AttributeType	*type;
	AttributeValue	*value;
} AttributeTypeAndValue;

AttributeTypeAndValue *KS_BIN_To_AttributeTypeAndValue	(BIN *bin);
void		KS_AttributeTypeAndValue_Free		(AttributeTypeAndValue *attributeTypeAndValue);

//
//	RelativeDistinguishedName
//
typedef struct _RelativeDistinguishedName {
	AttributeTypeAndValue	*attributeTypeAndValue;
} RelativeDistinguishedName;

RelativeDistinguishedName *KS_BIN_To_RelativeDistinguishedName(BIN *bin);
void		KS_RelativeDistinguishedName_Free	(RelativeDistinguishedName *relativeDistinguishedName);

//
//	RDNSequence
//
typedef struct _RDNSequence {
	RelativeDistinguishedName	*rdn;
	struct _RDNSequence 		*next;
} RDNSequence;

RDNSequence *KS_BIN_To_RDNSequence				(BIN *bin);
void		KS_RDNSequence_Free 				(RDNSequence *rdnSequence);

//
//	Name
//
typedef struct _Name {
	BIN 		*bin;
	RDNSequence *rdnSequence;
} Name;
	
Name		*KS_BIN_To_Name 					(BIN *bin);
void		KS_Name_Free						(Name *name);

//
//	SubjectPublicKeyInfo
//
typedef struct _SubjectPublicKeyInfo {
	BIN 				*bin;
	AlgorithmIdentifier *algorithm;
	BIT_STRING			*subjectPublicKey;
} SubjectPublicKeyInfo;

SubjectPublicKeyInfo 
			*KS_BIN_To_SubjectPublicKeyInfo 	(BIN *bin);
void		KS_SubjectPublicKeyInfo_Free		(SubjectPublicKeyInfo *subjectPublicKeyInfo);

//
//	UniqueIdentifier
//
typedef BIT_STRING	KSUniId;

KSUniId
			*KS_BIN_To_UniId (BIN *bin);
void		KS_UniId_Free			(KSUniId *uniId);

//
//	Extensions
//

typedef struct _Extension {
    BIN        objID;
    int      critical;  
    BIN         extnValue;
} Extension;

typedef struct _Extensions {
	struct _Extensions *next;
    Extension extension;
} Extensions;

//typedef BIN Extensions;

Extensions	*KS_BIN_To_Extensions				(BIN *bin);
void		KS_Extensions_Free					(Extensions *extensions);


//
//	TBSCertificate
//
typedef struct _TBSCertificate {
	Version 				*version;
	CertificateSerialNumber *serialNumber;
	AlgorithmIdentifier 	*signature;
	Name					*issuer;
	Validity				*validity;
	Name					*subject;
	SubjectPublicKeyInfo	*subjectPublicKeyInfo;
	KSUniId		*issuerUniqueID;	 // optional, v2 or v3
	KSUniId		*subjectUniqueID;	 // optional, v2 or v3
	Extensions				*extensions;		 // optional, v3
} TBSCertificate;

TBSCertificate *KS_BIN_To_TBSCertificate		(BIN *bin);
void		KS_TBSCertificate_Free				(TBSCertificate *tbsCertificate);

//
//	X509Certificate
//
typedef struct _X509Certificate {
	TBSCertificate		*tbsCertificate;
	AlgorithmIdentifier *signatureAlgorithm;
	BIT_STRING			*signature;
	BIN 				*binFingerPrint;
} X509Certificate;

X509Certificate *KS_BIN_To_X509Certificate		(BIN *bin);
X509Certificate *KS_PEM_To_X509Certificate		(char *pem);
void		KS_X509Certificate_Free 			(X509Certificate *x509Certificate);
int			KS_Get_Certificate_TBSCertificate	(ks_uint8*out, BIN *bin);
//
//	util
//
void		KS_X509Certificate_Print			(X509Certificate *x509Certificate, int tab_width);

char		*KS_Get_Certificate_Serial_Number	(X509Certificate *x509Certificate);
char		*KS_Get_Certificate_Subject			(X509Certificate *x509Certificate);
char		*KS_Get_Certificate_Subject_Email	(X509Certificate *x509Certificate);
char		*KS_Get_Certificate_Subject_ID		(X509Certificate *x509Certificate);
char		*KS_Get_Certificate_Subject_Name 	(X509Certificate *x509Certificate);
char		*KS_Get_Certificate_Issuer			(X509Certificate *x509Certificate);
char		*KS_Get_Certificate_Issuer_Name		(X509Certificate *x509Certificate);
char		*KS_Get_Certificate_Valid_From		(X509Certificate *x509Certificate);
char		*KS_Get_Certificate_Valid_To 		(X509Certificate *x509Certificate);
char		*KS_Get_Certificate_Validity 		(X509Certificate *x509Certificate);
char		*KS_Get_Certificate_Finger_Print 	(X509Certificate *x509Certificate);
char		*KS_Get_Certificate_Subject_Locality            (X509Certificate *x509Certificate);
char		*KS_Get_Certificate_Subject_StateOrProvinceName (X509Certificate *x509Certificate);
   
//char	   *KS_Get_Certificate_Extension		(X509Certificate *x509Certificate);
//added by solarsun 2005 08.14
char        *KS_Get_Certificate_Usage(X509Certificate *x509Certificate);
char		*KS_Get_Certificate_Policy			(X509Certificate *x509Certificate);
char		*KS_Get_Certificate_DN				(X509Certificate *x509Certificate);
char		*KS_Get_Certificate_OU				(X509Certificate *x509Certificate);
int 		KS_Check_Expired					(X509Certificate *x509Certificate);
int 		KS_Check_Sign						(X509Certificate *x509Certificate, PKCS1PublicKey *rsa);
unsigned char *KS_Get_Certificate_Vid			(X509Certificate *x509);
//added by choi 2009 08 19
//20130326 GPKI change function name
char		*KS_Get_Certificate_SignatureAlgorithm		(X509Certificate *x509Certificate);

//20130326 GPKI
char		*KS_Get_Certificate_Algorithm		(X509Certificate *x509Certificate);
char		*KS_Get_Certificate_Version			(X509Certificate *x509Certificate);
char		*KS_Get_Certificate_Valid_From_Format		(X509Certificate *x509Certificate);
char		*KS_Get_Certificate_Valid_To_Format		(X509Certificate *x509Certificate);
char		*KS_Get_Certificate_Valid_To_Format2    (X509Certificate *x509Certificate, bool isSystemTimeZone);
//added by choi 2011.07.26    
char        *KS_Get_Certificate_Organizationname(X509Certificate *x509Certificate);
//인증서 oid 가져오기. certmanager에서 가져옴.
int         KS_Get_Certificate_Oid(char *output, X509Certificate *x509Certificate);
    
// get user notice
int         KS_Get_Certificate_User_Notice(unsigned char *buffer, unsigned int maxBufferLen, X509Certificate *x509Certificate);
/**
 *
 */
PKCS1PublicKey *KS_X509Certificate_To_PKCS1PublicKey(X509Certificate *x509Certificate);

//added by choi 2010 03 25
int Cert_Verify_n_Get_PKCS1PublicKey(KS_CLIENT_CONFIG* config, PKCS1PublicKey *publicKey, 
									 ks_uint8 *cert, ks_uint16 cert_len);

//added by choi 2012 04 18
int KS_PEM_encode (char *out, ks_uint8 *in, int in_len, char *pem_header);
int KS_PEM_decode (ks_uint8 *output, char *pem);
int KS_PEM_decode_nonCRLF (ks_uint8 *output, char *pem);
    
int KS_Verify_Chain(KS_BYTE *serverCert, int serverCertLen, KS_BYTE *caCert, int caCertLen);

#ifdef	__cplusplus
}
#endif

#endif
