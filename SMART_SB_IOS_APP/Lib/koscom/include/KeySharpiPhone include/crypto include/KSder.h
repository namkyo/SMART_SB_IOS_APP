#ifndef __KSW_DER_H__
#define __KSW_DER_H__

#ifndef U8
typedef unsigned char U8;
#endif

/* Error code */
#define ERR_DER_INVALID_TAG				-1
#define ERR_DER_INVALID_LENGTH			-2

/* Der tag type */
#define DERTYPE_BOOLEAN					0x01
#define DERTYPE_INTEGER					0x02
#define DERTYPE_BITSTRING				0x03
#define DERTYPE_OCTETSTRING				0x04
#define DERTYPE_NULL					0x05
#define DERTYPE_OBJECTIDENTIFIER		0x06
#define DERTYPE_PRINTABLESTRING			0x13
#define DERTYPE_IA5STRING				0x16
#define DERTYPE_UTCTIME					0x17
#define DERTYPE_GENERALIZEDTIME			0x18
#define DERTYPE_UTF8STRING				0x0C
#define DERTYPE_SEQUENCE				0x30
#define DERTYPE_SET						0x31
#define DERTYPE_CONTEXTSPECIFIC			0xA0	/* P/C = 1 (Constructed) */

#ifdef  __cplusplus
extern "C" {
#endif

int		IntToByte (U8 *buf, int a);
int		ByteToInt (U8 *buf);

int		__set_len(U8 * location, int len);							/* Length Encode : only support case length is less than 64K */
int		__gen_len(U8 * location, int len);							/* Length Encode : only support case length is less than 64K */
int		__gen_len2(U8 * location, int len);							/* Length Encode : only support case length is less than 2^32bytes */
int		__SEQUENCE(U8 *buf, U8 **location, int l);					/* SEQUENCE : length is less than 64K */
int		__CONTEXTSPECIFIC(U8 *buf, U8 **location, U8 spec, int l);	/* Context-Specific : P/C = 1 (constructed), length is less than 64K */
int		__CONTEXTSPECIFIC0(U8 *buf, U8 **location, U8 spec, int l);	/* Context-Specific : P/C = 0 (primitive), length is less than 64K */
int		__INTEGER(U8 *buf, int value);								/* Two's complement is used. But this assume value is not negative */
int		__BITSTRING(U8 *buf, U8 *data, int len, U8 unused_bit);		/* BITSTRING : length is less than 64K */
int		__OCTETSTRING(U8 *buf, U8 *data, int len);
int		__NULL(U8 *buf);
int		__PrintableString(U8 *buf, char *str);
int     __UTF8(U8 *buf, char *str);

int		__get_len(U8 *buf, int *len);
int		__dSEQUENCE(U8 *buf, int *len);								/* decode SEQUENCE : length is less than 64K */
int		__dCONTEXTSPECIFIC(U8 *buf, int *len, int *spec);			/* decode Context-Specific : P/C = 1 (constructed), length is less than 64K */
int		__dINTEGER(U8 *buf, int *num);								/* decode INTEGER : value is less than 32K */
int		__dBITSTRING(U8 *out, U8 *buf, int *len, int *unused_bit);	/* BITSTRING : length is less than 64K */
int		__dOCTETSTRING(U8 *out, U8 *buf, int *len);

#ifdef  __cplusplus
}
#endif

#endif
