
#ifndef	__KSW_CLIENT_H__
#define	__KSW_CLIENT_H__

#ifdef  __cplusplus
extern "C" {
#endif

#include "KSdefine.h"
#include "KSerror.h"
#include "KSsha.h"
#include "KSseed.h"
#include "KSpkcs1.h"
#include "KSprotocol.h"
//#define far

/*	client config */
typedef struct {
//	char				server_cert_file[MAX_PATH_LEN];
	PKCS1PublicKey		*server_rsa;
	ks_uint8				server_certhash[SHA_DIGEST_LENGTH];
} KS_CLIENT_CONFIG;


/*	client context */
typedef struct {
	KS_CLIENT_CONFIG	config;
    ks_uint8               secret[SECRET_SIZE];
	ks_uint8				compress;
	KS_SHA_CTX				sha_ctx;
	ks_uint8				client_MAC_secret[SHA_DIGEST_LENGTH];
	ks_uint8				server_MAC_secret[SHA_DIGEST_LENGTH];
	ks_uint8				client_write_key[SEED_KEY_SIZE];
	ks_uint8				server_write_key[SEED_KEY_SIZE];
	ks_uint8				client_IV[SEED_IV_SIZE];
	ks_uint8				server_IV[SEED_IV_SIZE];

	ks_uint8				sid[20];
	ks_uint8				sid_len;
    
	ks_uint32				client_seq;
	ks_uint32				server_seq;
} KS_CLIENT_CTX;

/**
 *	ClientLib_Init :
 *	
 *	output : rand_seed			:
 *	input  : ctx				: pointer to Client Context
 *			 xmc_path			: SEED data file & ca.db directory (optional for NO_GLOBAL)
 *			 cert_filename		: server cert file name (optional for ENABLE_FILE)
 *			 server_cert		: pointer to DER encoded server_cert (optional for !ENABLE_FILE)
 *			 server_cert_length	: length of server_cert (optional for !ENABLE_FILE)
 *
 *	return : 1					: success
 *			 error <= 0			: fail
 */
int
KS_ClientLib_Init (KS_CLIENT_CTX *ctx , ks_uint8 *cert, ks_uint16 cert_length);
    
int
KS_ClientLib_InitEx (KS_CLIENT_CTX *ctx , ks_uint8 *cert, ks_uint16 cert_length , int isLength4byte);

int		
KS_Encode_KeyInit_Token	(KS_CLIENT_CTX  *ctx, 
							 ks_uint8  *output, ks_uint16 *output_length, ks_uint16 output_max_length);

int		
KS_Decode_KeyFinal_Token  (KS_CLIENT_CTX  *ctx, 
							 ks_uint8  *input, ks_uint16 input_length);

int		
KS_Encrypt_Message        (KS_CLIENT_CTX  *ctx, 
							 ks_uint8  *output, ks_uint32 *output_length, ks_uint32 output_max_length,  
                             ks_uint8  *message, ks_uint32 message_length);

int 
KS_Decrypt_Message        (KS_CLIENT_CTX  *ctx, 
							 ks_uint8  *output, ks_uint32 *output_length, ks_uint32 output_max_length,
						     ks_uint8  *input, ks_uint32 input_length);
int  
KS_Encrypt_MessageEx    (KS_CLIENT_CTX  *ctx, 
                           ks_uint8  *output, ks_uint32 *output_length, ks_uint32 output_max_length,
                           ks_uint8  *message, ks_uint32 message_length);
int 
KS_Decrypt_MessageEx    (KS_CLIENT_CTX  *ctx, 
                           ks_uint8  *output, ks_uint32 *output_length, ks_uint32 output_max_length,
                           ks_uint8  *input, ks_uint32 input_length);
int
File_Write					(char *file_name, ks_uint8 *bin, ks_uint16 bin_len);

int
File_Read					(char *file_name, ks_uint8 *bin, ks_uint16 max_len);


#ifdef  __cplusplus
}
#endif

#endif
