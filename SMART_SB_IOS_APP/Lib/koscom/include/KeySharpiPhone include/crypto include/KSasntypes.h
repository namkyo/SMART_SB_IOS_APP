//
//	KS_asntypes.h
//

#ifndef __KSW_ASNTYPES_H__
#define __KSW_ASNTYPES_H__

#include "KSbin.h"
#include <time.h>

#define ASN1_MASK_TAG_NUMBER			0x1F
#define ASN1_MASK_CONSTRUCTED			0x20

#define ASN1_TAG_INTEGER				0x02
#define ASN1_TAG_BIT_STRING 			0x03
#define ASN1_TAG_OCTET_STRING			0x04
#define ASN1_TAG_NULL					0x05
#define ASN1_TAG_OBJECT_IDENTIFIER		0x06
//#define ASN1_TAG_SEQUENCE				0x10
#define ASN1_TAG_SEQUENCE				0x30
#define ASN1_TAG_SEQUENCE_OF			0x10
#define ASN1_TAG_SET					0x11
#define ASN1_TAG_SET_OF 				0x11
#define ASN1_TAG_PrintableString		0x13
#define ASN1_TAG_T61String				0x14
#define ASN1_TAG_IA5String				0x16
#define ASN1_TAG_UTCTime				0x17


#define	ASN1_ENCODE_START(buf, pos, eval)			\
{													\
	(pos) = 0;										\
	(buf) = (KS_BYTE *) (eval);						\
}

#define	ASN1_DECODE_START(buf, pos, eval)			\
{													\
	(pos) = 0;										\
	(buf) = (KS_BYTE *) (eval);						\
}

#define	ASN1_TYPE_ENCODE(buf, pos, tag)				\
{													\
	(buf)[(pos)++] = (tag);							\
}

#define	ASN1_TYPE_DECODE(buf, pos, tag)				\
{													\
	(tag) = (buf)[(pos)++];							\
}

#define	ASN1_VALUE_ENCODE(buf, pos, val, len)		\
if (len > 0) {										\
	memcpy(buf + pos, val, len);					\
	pos += len;										\
}

#define	ASN1_VALUE_DECODE_PINTEGER(buf, pos, len, bigint)	\
{													\
	if ((bigint) == NULL)							\
		(bigint) = Big_Create((len + 3) / 4);	\
	if ((bigint) == NULL) {							\
		errorCode = KS_ERR_MALLOC_FAILED;	\
		goto error;									\
	}												\
	errorCode = Big_ByteSequenceToInt((bigint), buf + pos, len);	\
	if (errorCode != 0) goto error;					\
	pos += len;										\
}


//	in/out	: buf, pos
//	out		: len_count
//	in		: len
//

#define	ASN1_LENGTH_ENCODE(buf, pos, len, len_count)	\
{													\
	ks_uint8		c, i;								\
													\
	c = 0;											\
	if ((len) >= 0x80) {							\
		c += 1;										\
		for (i=1; i<4; i++) 						\
			if ((len) >> (i << 3)) c++;				\
		(buf)[(pos)++] = 0x80 ^ c;					\
		for (i=0; i<c; i++)							\
			(buf)[(pos)++] = ((len) >> ((c-i-1) << 3));	\
	}												\
	else											\
		(buf)[(pos)++] = (len);						\
	len_count = c + 1;								\
}

int	asn1_length_encode(ks_uint8 *buf, int *pos, int len);

//	in/out	: buf, pos
//	out		: len, len_count
//

#define	ASN1_LENGTH_DECODE(buf, pos, len, len_count)	\
{													\
	ks_uint8		c, i;								\
													\
	c = 0;											\
	if ((buf)[(pos)] & 0x80) {						\
		c = (buf)[(pos)++] & 0x7F;					\
		(len) = 0;									\
		for (i=0; i<c; i++)							\
			(len) = (len) * 256 + (buf)[(pos)++];	\
	}												\
	else											\
		(len) = (buf)[(pos)++] & 0x7F;				\
	len_count = c + 1;								\
}

int	asn1_length_decode(ks_uint8 *buf, int *pos, int *len);

//	in/out	: buf, pos
//	out		: len, len_count
//

#define ASN1_X509_LENGTH_DECODE(buf, pos, len, len_count)	\
{														\
	int i;												\
														\
	len_count = 0;										\
	if (buf[pos] & 0x80) {								\
		len_count = buf[pos++] & 0x7F;					\
		len = 0;										\
		for (i = 0; i < len_count; i++) 				\
			len = len * 256 + buf[pos++];				\
	}													\
	else												\
		len = buf[pos++] & 0x7F;						\
}

#define	ASN1_LENGTH_CHECK(pos, len, total)			\
if ((pos + len) > total) {							\
	errorCode = KS_ERR_ASN1_ERROR_BAD_LENGTH;			\
	goto error;										\
}

#define	ASN1_TYPE_CHECK(buf, pos, tag)				\
if ((buf)[(pos)++] != (tag)) {						\
	errorCode = KS_ERR_ASN1_ERROR_BAD_DATA;				\
	goto error;										\
}

int asn1_x509_length_decode(ks_uint8 *buf, int *pos, int *len);



#ifdef	__cplusplus
extern "C" {
#endif

//
//	BIT_STRING
//
typedef BIN BIT_STRING;

BIT_STRING	*KS_BIN_To_BIT_STRING				(BIN *bin);
void		KS_BIT_STRING_Free					(BIT_STRING *bit_STRING);

//
//	INTEGER
//
typedef BIN INTEGER;

INTEGER 	*KS_BIN_To_INTEGER					(BIN *bin);
void		KS_INTEGER_Free 					(INTEGER *integer);

//
//	OBJECT_IDENTIFIER
//
typedef BIN OBJECT_IDENTIFIER;

OBJECT_IDENTIFIER *KS_BIN_To_OBJECT_IDENTIFIER	(BIN *bin);
void		KS_OBJECT_IDENTIFIER_Free			(OBJECT_IDENTIFIER *object_IDENTIFIER);

//
//	ASN_ANY
//
typedef BIN ASN_ANY;

ASN_ANY 	*KS_BIN_To_ASN_ANY					(BIN *bin);
void		KS_ASN_ANY_Free 					(ASN_ANY *asn_ANY);

//
//	Time
//
typedef BIN Time;

Time		*KS_BIN_To_Time 					(BIN *bin);
void		KS_Time_Free						(Time *time);

//
//	AlgorithmIdentifier
//
typedef struct _AlgorithmIdentifier {
	OBJECT_IDENTIFIER	*algorithm;
	ASN_ANY 			*parameters;
} AlgorithmIdentifier;

AlgorithmIdentifier *KS_AlgorithmIdentifier_New ();
AlgorithmIdentifier *KS_BIN_To_AlgorithmIdentifier(BIN *bin);
void		KS_AlgorithmIdentifier_Free 		(AlgorithmIdentifier *algorithmIdentifier);



void KS_time2utc(time_t t, ks_uint8 *buf, int pos);

#ifdef	__cplusplus
}
#endif

#endif
