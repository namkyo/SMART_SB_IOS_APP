#ifndef	__KSW_CMPPROTO_H__
#define	__KSW_CMPPROTO_H__

#include "KSder.h"

/* Size */
#define CMP_SIZE_CBCDESMAC			8
#define CMP_SIZE_HASH				20
#define CMP_SIZE_RANDLENGTH			16
#define CMP_SIZE32					32
#define CMP_SIZE64					64
#define CMP_SIZE128					128
#define CMP_SIZE256					256
#define CMP_SIZE512					512
#define CMP_SIZE1K					1024
#define CMP_SIZE2K					(CMP_SIZE1K)*2
#define CMP_SIZE6K					(CMP_SIZE1K)*6
	
/* PKIMessage */
#define CMP_MSGTYPE_IRP				0x31
#define CMP_MSGTYPE_KURP			0x32
#define CMP_MSGTYPE_RRP				0x33
#define CMP_MSGTYPE_KRRP			0x34

/* PKIMessage Body */
#define CMP_BODYTYPE_IR					0
#define CMP_BODYTYPE_IP					1
#define CMP_BODYTYPE_KUR				7
#define CMP_BODYTYPE_KUP				8
#define CMP_BODYTYPE_KRR				9
#define CMP_BODYTYPE_KRP				10
#define CMP_BODYTYPE_RR					11
#define CMP_BODYTYPE_RP					12
#define CMP_BODYTYPE_CONF				19
#define CMP_BODYTYPE_GENM				21
#define CMP_BODYTYPE_GENP				22
#define CMP_BODYTYPE_ERROR				23

/* TCP-based flag */
#define	CMP_TCPFLAG_PKIMSG				0x00
#define	CMP_TCPFLAG_POLLREP				0x01
#define	CMP_TCPFLAG_POLLREQ				0x02
#define	CMP_TCPFLAG_NEGPOLLREP			0x03
#define	CMP_TCPFLAG_PARTIALMSGREP		0x04
#define	CMP_TCPFLAG_FINALMSGREP			0x05
#define	CMP_TCPFLAG_ERRORMSGREP			0x06

/* TCP-based type */
#define	CMP_TCPTYPE_PKIREQ				0x00
#define CMP_TCPTYPE_POLLREP				0x01
#define CMP_TCPTYPE_POLLREQ				0x02
#define CMP_TCPTYPE_FINREP				0x03
#define CMP_TCPTYPE_PKIREP				0x05
#define CMP_TCPTYPE_ERRORMSGREP			0x06

#define	_CMP_STR_CLNTNAME				" "
#define	_CMP_STR_CLNTNAME_SIGNKOREA		"KS_STB_NEW"
#define	_CMP_STR_SRVRNAME				"PKI"
#define	_CMP_STR_FIXED_IDN				"1234561234567"
#define	_CMP_STR_FIXED_IDN_SIGNGATE		"1234561234563"
#define	_CMP_STR_CLASS_ID				"0000"

typedef struct {
	/* Arguments */
	int		ca_name;
    int     signkorea_kmcert_flag; //added by choi 2012.04.09
	int		msg_type;
	int		body_type;
	char	ref_num[CMP_SIZE64];
	char	auth_code[CMP_SIZE32];

	
	/* Message Fields */
	U8		clnt_nonce[CMP_SIZE128];
	int		clnt_nonce_len;
	U8		srvr_nonce[CMP_SIZE128];
	int		srvr_nonce_len;
	int		failure_info;

	/* CA and Root Cert */
	U8		cacert[CMP_SIZE2K];
	int		cacert_len;
	U8		cakmcert[CMP_SIZE2K];
	int		cakmcert_len;
	U8		rootcert[CMP_SIZE2K];
	int		rootcert_len;

	/* User Cert */
	U8		sign_cert[CMP_SIZE2K];
	int		sign_cert_len;
	int		encrypt_flag_of_signcert;
	U8		sign_pri[CMP_SIZE2K];
	int		sign_pri_len;
	int		encrypt_flag_of_signpri;
	U8		km_cert[CMP_SIZE2K];
	int		km_cert_len;
	int		encrypt_flag_of_kmcert;
	U8		km_pri[CMP_SIZE2K];
	int		km_pri_len;
	int		encrypt_flag_of_kmpri;
	U8		old_cert[CMP_SIZE2K];
	int		old_cert_len;
	U8		old_prikey[CMP_SIZE2K];
	int		old_prikey_len;
	U8		old_kmcert[CMP_SIZE2K];
	int		old_kmcert_len;
	U8		old_kmprikey[CMP_SIZE2K];
	int		old_kmprikey_len;

	/* Keys */
	U8		pubkey[CMP_SIZE2K];
	int		pubkey_len;
	U8		prikey[CMP_SIZE2K];
	int		prikey_len;
	U8		kmpubkey[CMP_SIZE2K];
	int		kmpubkey_len;
	U8		kmprikey[CMP_SIZE2K];
	int		kmprikey_len;
    //[2013.04.08] CMP_SIZE32 -> CMP_SIZE64 
	char	passwd[CMP_SIZE64];
	/* 2006.3.15. cho : for signgate */
	U8		skey[8];

	/* idn and vid random */
	U8		random[20];

} PKIMessage_CTX;


typedef struct {
	int		key_size;
	int		dump_flag;
	char	dump_dir[CMP_SIZE512];
} Option;

#endif



/*
--------------------------------------------------------------------------
AlgorithmIdentifier  ::=  SEQUENCE  {
        algorithm               OBJECT IDENTIFIER,
        parameters              ANY DEFINED BY algorithm OPTIONAL  }
--------------------------------------------------------------------------
GeneralName ::= CHOICE {
           otherName                       [0]     OtherName,
           rfc822Name                      [1]     IA5String,
           dNSName                         [2]     IA5String,
           x400Address                     [3]     ORAddress,
           directoryName                   [4]     Name,
           ediPartyName                    [5]     EDIPartyName,
           uniformResourceIdentifier       [6]     IA5String,
           iPAddress                       [7]     OCTET STRING,
           registeredID                    [8]     OBJECT IDENTIFIER}

      OtherName ::= SEQUENCE {
           type-id    OBJECT IDENTIFIER,
           value      [0] EXPLICIT ANY DEFINED BY type-id }

      EDIPartyName ::= SEQUENCE {
           nameAssigner            [0]     DirectoryString OPTIONAL,
           partyName               [1]     DirectoryString }
--------------------------------------------------------------------------
Certificate  ::=  SEQUENCE  {
        tbsCertificate       TBSCertificate,
        signatureAlgorithm   AlgorithmIdentifier,
        signatureValue       BIT STRING  }
-------------------------------------------------------------------------
TBSCertificate  ::=  SEQUENCE  {
    version         [0]  EXPLICIT Version DEFAULT v1,
    serialNumber         CertificateSerialNumber,
    signature            AlgorithmIdentifier,
    issuer               Name,
    validity             Validity,
    subject              Name,
    subjectPublicKeyInfo SubjectPublicKeyInfo,
    issuerUniqueID  [1]  IMPLICIT UniqueIdentifier OPTIONAL,
                         -- If present, version shall be v2 or v3
    subjectUniqueID [2]  IMPLICIT UniqueIdentifier OPTIONAL,
                         -- If present, version shall be v2 or v3
    extensions      [3]  EXPLICIT Extensions OPTIONAL
                         -- If present, version shall be v3
    }
-------------------------------------------------------------------------
Version  ::=  INTEGER  {  v1(0), v2(1), v3(2)  }
-------------------------------------------------------------------------
CertificateSerialNumber  ::=  INTEGER
-------------------------------------------------------------------------
Validity ::= SEQUENCE {
	notBefore      Time,
	notAfter       Time }
-------------------------------------------------------------------------
Time ::= CHOICE {
	utcTime        UTCTime,
	generalTime    GeneralizedTime }
-------------------------------------------------------------------------
UniqueIdentifier  ::=  BIT STRING
-------------------------------------------------------------------------
SubjectPublicKeyInfo  ::=  SEQUENCE  {
	algorithm            AlgorithmIdentifier,
	subjectPublicKey     BIT STRING  }
-------------------------------------------------------------------------
Extensions  ::=  SEQUENCE SIZE (1..MAX) OF Extension
-------------------------------------------------------------------------
Extension  ::=  SEQUENCE  {
	extnID      OBJECT IDENTIFIER,
	critical    BOOLEAN DEFAULT FALSE,
	extnValue   OCTET STRING  }
-------------------------------------------------------------------------
*/
