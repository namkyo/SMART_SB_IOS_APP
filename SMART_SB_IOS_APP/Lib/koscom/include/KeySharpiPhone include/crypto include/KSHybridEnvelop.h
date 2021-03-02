//
//  KSHybridEnvelop.h
//  CertmanagerLibrary
//
//  Created by seong-hwan seok on 12. 11. 21..
//
//

#ifndef CertmanagerLibrary_KSHybridEnvelop_h
#define CertmanagerLibrary_KSHybridEnvelop_h

#include "KSClient.h"
//#include "Util.h"
#include "KSBase64.h"
#include "KShmac.h"
#include "KSsha.h"

//KSH length define
#define KSH_SID_LEN     20
//#define KSH_SID_LEN     32
#define KSH_IV_LEN      16
#define KSH_KEY_LEN     16
#define KSH_MACKEY_LEN  20
#define KSH_MAC_LEN     20
#define KSH_DUMMY_LEN   8

#define KSH_PADDING_MAX_LEN 16
#define KSH_ENC_MAX_DATA_LEN 40960


//KSH struct
typedef struct{
	ks_uint8 sid[KSH_SID_LEN];
    ks_uint8 iv[KSH_IV_LEN];
    ks_uint8 key[KSH_KEY_LEN];
    ks_uint8 mackey[KSH_MACKEY_LEN];
    ks_uint8 dummy[KSH_DUMMY_LEN];
    
    ks_uint32 sidLen;
    ks_uint32 ivLen;
    ks_uint32 keyLen;
    ks_uint32 mackeyLen;
    ks_uint32 dummyLen;
    
    int isMake;
} KSH_ENC_CTX;

#ifdef  __cplusplus
extern "C" {
#endif
    
    int getKSHDBKeyInfo( KSH_ENC_CTX* dbEnc_ctx);
    int getKSHServerKeyInfo(KSH_ENC_CTX* sercerEnc_ctx , KSH_ENC_CTX* dbEnc_ctx);
    int getSidFromServerMsg(ks_uint8* sid , ks_uint8* serverMsg , ks_uint32 serverMsgLen , int decodingFlag);
    KS_BYTE* KSH_makeIvDB(ks_uint8* src);
    KS_BYTE* KSH_makeKeyDB(ks_uint8* src);
    int KSH_SEED_CBC_Encrypt_DB(ks_uint8 *psOutput, ks_uint8 *psInput, KS_WORD nInputLength,  ks_uint8 *psIV, ks_uint8 *psKey ,ks_uint8 *srcIV , ks_uint8 *srcKEY);
    int KSH_SEED_CBC_Decrypt_DB(ks_uint8 *psOutput, ks_uint8 *psInput, KS_WORD nInputLength,  ks_uint8 *psIV, ks_uint8 *psKey ,ks_uint8 *srcIV , ks_uint8 *srcKEY);
    ks_uint8* makeIv(ks_uint8* src);
    ks_uint8* makeKey(ks_uint8* src);
    
    int KSH_Envelope(KSH_ENC_CTX *kshenc_ctx,
                 ks_uint8 *output,
                 ks_uint32 output_max_length,
                 ks_uint8 *input, ks_uint32 input_length ,
                 ks_uint8 *cert, int cert_length,
                 int encAlg,
                 int encodingFlag
                 );
    
    
    int KSH_Decode(KSH_ENC_CTX* sercerEnc_ctx , KSH_ENC_CTX* dbEnc_ctx ,
                    ks_uint8 *output,
                    ks_uint32 output_max_length,
                    ks_uint8 *input, ks_uint32 input_length ,
                    int decodingFlag,
                    int encodingFlag);

    
#ifdef __cplusplus
} // of extern "C"
#endif

#endif
