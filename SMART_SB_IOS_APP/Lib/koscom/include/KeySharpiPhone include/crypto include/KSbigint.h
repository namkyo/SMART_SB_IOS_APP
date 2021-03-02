#ifndef __KSW_BIGINT_H__
#define __KSW_BIGINT_H__

#include "KSdefine.h"

/* =================
 *    Basis types 
 * =================
 */

typedef struct{
    int			MemLength;
	int			Length;
	int			Sign;
	KS_WORD		*Data;
} BigInt;



/* ===============
 *    Constants
 * ===============
 */

#define     DEFAULT_MEMALLOC_LENGTH       33                              // default memory allocation length for BigInt
#define		MAX_PRECOMPUTATION			  64							  // maximum precomputation number for sliding windows method
#define		KS_ASN1_INTEGER				   2
#define		KS_ASN1_NULL                   5
#define		KS_ASN1_SEQUENCE				0x30
#define		KS_FOOLISH_INTEGER				0x20



/* ============
 *    MACROS
 * ============
 */

#define		BigIntIsZero(x)				( ((x)->Length == 1 ) && ((x)->Data[0] == 0) )
#define		BigIntIsOne(x)				( ((x)->Length == 1 ) && ((x)->Data[0] == 1) )
#define		BigIntIsOdd(x)				( (x)->Data[0] & 1 )
#define		BigIntIsEven(x)				( ((x)->Data[0] & 1 ) == 0 )

/***
 ***	If only 32 bit operations are available,
 ***

#define		INT32_Add(R, C, A, B, T )			\
{												\
	R = A + B;									\
	C = (((A ^ B ) & ~R ) | (A & B ) ) >> 31;	\
}



  ***
  ***
  ***/

#ifdef __cplusplus
extern "C" {
#endif

/* =========================
 *    Function prototypes
 * =========================
 */
 
int			Big_AbsoluteCompare		( BigInt *x, BigInt	*y);									// comparing with absolute values
KS_WORD		Big_AbsoluteDecrease	( BigInt *x );
KS_WORD		Big_AbsoluteIncrease	( BigInt *x );
KS_WORD     _KS_Big_Add                 ( BigInt *x, BigInt *y, BigInt *z);
int			Big_BinaryExpansion		( KS_BYTE *x, BigInt *y);									// binary representation
int			Big_ByteLength			( BigInt *x );
KS_WORD		Big_ByteSequenceToInt	( BigInt *x, KS_BYTE *y, int z );
int         Big_Compare             ( BigInt *x, BigInt *y);                                    // returns sign ( x - y)
KS_WORD     Big_Copy                ( BigInt *x, BigInt *y);                                    // x <- y
BigInt      *Big_Create             ( int     x );												// BigInt creation
KS_WORD		_Big_DerDecode			( BigInt *x, KS_BYTE *y, int z );
KS_WORD		_Big_DerEncode			( KS_BYTE *x, BigInt *y, int *z );
KS_WORD		_Big_DerLength			( BigInt *x );
KS_WORD     _KS_Big_DivByWord           ( BigInt *x, KS_WORD *r, BigInt *y, KS_WORD z);             // x = y / z
KS_WORD     Big_Divide              ( BigInt *x, BigInt *r, BigInt *y, BigInt *z);              // y = x * z + r
KS_WORD     _KS_Big_ExtendedGCD         ( BigInt *z, BigInt *a, BigInt *b, BigInt *x, BigInt *y);	// ax + by = gcd ( x, y)
void        Big_Free                ( BigInt *x);                                               // memory free
KS_WORD     _KS_Big_GCD                 ( BigInt *x, BigInt *y, BigInt *z);                         // x = gcd ( y, z)
KS_WORD		Big_IntToByteSequence	( KS_BYTE *x, BigInt *y, int z );
KS_WORD     Big_LeftShiftByBit      ( BigInt *x, BigInt *y, int shiftBitLength);				// x = y << shiftBitLength
KS_WORD     Big_LeftShiftByWord     ( BigInt *x, BigInt *y, int shiftWordLength);				// x = y << ( shiftWordLength * 32)
KS_WORD     Big_ModReduction        ( BigInt *x, BigInt *y, BigInt *z);                         // x = y ( mod z)
KS_WORD		Big_ModReductionByWord	( BigInt *x, KS_WORD y );
KS_WORD		_KS_Big_ModExp  			( BigInt *x, BigInt *y, BigInt *z, BigInt *w);				// x = y^z  ( mod w )
KS_WORD		Big_ModExpMont			( BigInt *x, BigInt *y, BigInt *z, BigInt *w);
KS_WORD		Big_ModExpWindow		( BigInt *x, BigInt *y, BigInt *z, BigInt *w);
KS_WORD		_KS_Big_ModExpWindowMont	( BigInt *x, BigInt *y, BigInt *z, BigInt *w);				// z = x^y mod m ( slide-window mwthod )
KS_WORD     Big_ModInverse          ( BigInt *x, BigInt *y, BigInt *z);							// x = y^{-1} ( mod z)
KS_WORD		Big_MontgomeryInit		( BigInt *x, KS_WORD *y, BigInt *z );						// x = R^2 mod m and y = -m^(-1) mod b     
KS_WORD		Big_MontgomeryReduction	( BigInt *z, BigInt *x, BigInt *m, KS_WORD c);				// z = x(R^(-1)) mod m, where R = b^(length od m)
KS_WORD		Big_MontgomeryMult		( BigInt *z, BigInt *x, BigInt *y, BigInt *m, KS_WORD c);	// z = xy(R^(-1)) mod m, where R = b^(length od m)
KS_WORD		Big_MontgomerySquare	( BigInt *z, BigInt *x, BigInt *m, KS_WORD c);				// z = (x^2)(R^(-1)) mod m, where R = b^(length od m)
KS_WORD     Big_Mult                ( BigInt *x, BigInt *y, BigInt *z);                         // x = y * z
KS_WORD     Big_MultByWord          ( BigInt *x, BigInt *y, KS_WORD z);                         // x = y * z
KS_WORD     Big_Print               ( char   *x, BigInt *y);
KS_WORD		Big_Realloc				( BigInt *x, int wordLength);
KS_WORD     Big_Reset               ( BigInt *x, int y);                                        // x <- y
KS_WORD     Big_RightShiftByBit     ( BigInt *x, BigInt *y, int shiftBitLength);				// x = y >> shiftBitLength
KS_WORD     Big_RightShiftByWord    ( BigInt *x, BigInt *y, int shiftWordLength);				// x = y >> ( shiftWordLength * 32)
KS_WORD     Big_Square              ( BigInt *x, BigInt *y);                                    // x = y ^ 2
KS_WORD     _KS_Big_Sub                 ( BigInt *x, BigInt *y, BigInt *z);                         // x = y - z

int			Big_ModMul				(BigInt *result, BigInt *inputA, BigInt *inputB, BigInt *mod );	// x = y*z  ( mod w )
KS_WORD		_KS_Big_GetFilledBitNum		( BigInt *a);
//int			BigInt_ModExpWindow2	(BigInt *output, BigInt *input, BigInt *exponent, BigInt *mod, BigInt *rSqr, KS_WORD modInv);
KS_WORD		Big_RShiftBit(BigInt *result, BigInt *input, int shiftBitLength );

#ifdef __cplusplus
} // of extern "C"
#endif

																								
/* ==================
 *	  Error Define
 * ==================
 */

/* =====================
 *    Error Code
 * =====================
 */

#define		INVALID_INPUT					0xff
#define		MALLOC_FAILURE					1
#define		NOT_SUPPORTED_ALG				2
#define		INVALID_KEY						3
#define		VERIFY_FAIL						4

#define		BIGINT_ERROR						0x80010000
#define		BIGINT_INVALID_INPUT				(BIGINT_ERROR + INVALID_INPUT )
#define		BIGINT_MALLOC_FAILURE				(BIGINT_ERROR + 1 )
#define		BIGINT_DIVIDE_BY_ZERO				(BIGINT_ERROR + 0x21 )
#define		BIGINT_GCD_IS_NOT_ONE				(BIGINT_ERROR + 0x22 )
#define		BIGINT_DER_ERROR					(BIGINT_ERROR + 0x23 )


#endif
