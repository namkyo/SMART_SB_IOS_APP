#ifndef __KSW_RP_H__
#define __KSW_RP_H__

#define RMSGTYPE_REQ_POP			1
#define RMSGTYPE_RES_POP			2
#define RMSGTYPE_REQ_STORE			3
#define RMSGTYPE_RES_STORE			4
#define RMSGTYPE_REQ_CERTLIST		5
#define RMSGTYPE_RES_CERTLIST		6
#define RMSGTYPE_REQ_RESTORE		7
#define RMSGTYPE_RES_RESTORE		8
#define RMSGTYPE_RES_ERROR			100

#define RESULTCODE_POPOK			1
#define RESULTCODEMSG_POPOK			"º“¿Ø¿⁄»Æ¿Œ¿Ã ¿Ã∑ÁæÓ¡≥Ω¿¥œ¥Ÿ."
#define RESULTCODE_STOREOK			2
#define RESULTCODEMSG_STOREOK		"¿Œ¡ıº≠∞° º∫∞¯¿˚¿∏∑Œ ¿˙¿Âµ«æ˙Ω¿¥œ¥Ÿ."

#define CERTLISTTYPE_CERT			1
#define CERTLISTTYPE_CERTINFO		2

#define ks_uint8	unsigned char
#define ks_uint16	unsigned short
#define ks_uint32	unsigned int

/*
RMSG ::= {
	ks_uint8		msgType;
	uint16		version;
	uint16		msgLength;

	select(type) {
	case 1 : ReqPop;			// º“¿Ø¿⁄ »Æ¿Œ ø‰√ª
	case 2 : ResPop;			// º“¿Ø¿⁄ »Æ¿Œ ¿¿¥‰
	case 3 : ReqStore;			// ¿Œ¡ıº≠ ≥ª∫∏≥ª±‚ ø‰√ª
	case 4 : ResStore;			// ¿Œ¡ıº≠ ≥ª∫∏≥ª±‚ ¿¿¥‰
	case 5 : ReqCertList;		// ¿Œ¡ıº≠ ¡§∫∏∏ÆΩ∫∆Æ ø‰√ª
	case 6 : ResCertList;		// ¿Œ¡ıº≠ ¡§∫∏∏ÆΩ∫∆Æ ¿¿¥‰
	case 7 : ReqRestore;		// ¿Œ¡ıº≠ ∞°¡Æø¿±‚ ø‰√ª
	case 8 : ResRestore;		// ¿Œ¡ıº≠ ∞°¡Æø¿±‚ ¿¿¥‰

	case 100 : ResError;
	}
}

-------------------------------------------------------
ReqPop ::= {
	Cert	cert;
	uint16	length;
	ks_uint8	signedCertHash[length];
}
-------------------------------------------------------
ResPop ::= ResultMsg;

ResultMsg ::= {
	ks_uint32	resultCode;
	uint16	length;
	ks_uint8	msg[length];
}
-------------------------------------------------------
ReqStore ::= {
	AuthParam	authParam;			
	Cert		cert;
	Pfx			pfx;
}

AuthParam ::= {
	ks_uint8	uid[20];
	ks_uint8	SHA1hashedPassword[20];
}

Cert ::= {
	uint16	length;
	ks_uint8	cert[length];
}

Pfx ::= {
	uint16		p12Length;
	ks_uint8		p12Data[p12Length];
}
-------------------------------------------------------	
ResStore ::= ResultMsg;
-------------------------------------------------------	
ReqCertList ::= {
	AuthParam	authParam;
	ks_uint8		certListType;
}
-------------------------------------------------------	
ResCertList ::= {
	ks_uint8	certListType;
	ks_uint8	numOfCerts;

	select(certListType) {
	case 1 : Cert		certs[num];
	case 2 : CertInfo	certInfos[num];
	}
}

CertInfo ::= {
	uint16	length;
	ks_uint8	info[length];	// This may be defined explicitly.
}
-------------------------------------------------------	
ReqRestore ::= {
	AuthParam	authParam;
	Cert		cert;
}
-------------------------------------------------------	
ResRestore ::= Pfx;
-------------------------------------------------------	
ResError ::= ResultMsg;
-------------------------------------------------------
*/

/* 
-------------------------------------------------------	
¿Œ¡ıº≠ ≥ª∫∏≥ª±‚ ¿˝¬˜
-------------------------------------------------------	
Client								Relay Server
		---- Connect Request ----->
		<------ Handshake -------->
		---Encrypted [ReqPop]----->					
		<--Encrypted [ResPop]----->
		---Encrypted [ReqStore]--->
		<--Encrypted [ResStore]----

-------------------------------------------------------	
¿Œ¡ıº≠ ∏ÆΩ∫∆Æ ∞°¡Æø¿±‚ ¿˝¬˜
-------------------------------------------------------	
Client								Relay Server
		---- Connect Request ----->
		<------ Handshake -------->
		---Encrypted [ReqCertList]-->
		<--Encrypted [ResCertList]---

-------------------------------------------------------	
¿Œ¡ıº≠ ∞°¡Æø¿±‚ ¿˝¬˜
-------------------------------------------------------	
Client								Relay Server
		---- Connect Request ----->
		<------ Handshake -------->
		---Encrypted [ReqRestore]-->
		<--Encrypted [ResRestore]---
-------------------------------------------------------	
*/

#endif
