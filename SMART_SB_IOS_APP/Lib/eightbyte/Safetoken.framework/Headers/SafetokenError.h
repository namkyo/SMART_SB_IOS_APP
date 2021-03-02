//
//  SafetokenError.h
//  Safetoken
//
//  Created by KimMinSu on 27/02/2019.
//  Copyright © 2019 8byte. All rights reserved.
//

#ifndef SafetokenError_h
#define SafetokenError_h

#define SAFETOKEN_CLIENT_ERROR_DOMAIN   @"SafetokenClientError"

#define ERROR_INVALID_ARGUMENT          -10000

#define ERROR_READ_FILE                 -10011
#define ERROR_WRITE_FILE                -10012
#define ERROR_STORE_TOKEN               -10013
#define ERROR_REMOVE_TOKEN              -10014
#define ERROR_CREATE_PATH               -10015
#define ERROR_INVALID_TOKEN             -10016
#define ERROR_SET_DIR                   -10017
#define ERROR_INVALID_DEVICE_HASH       -10018
#define ERROR_NOT_EXIST_TOKEN           -10019

#define ERROR_SECURE_UUID               -10020
#define ERROR_SECURE_PWD                -10021
#define ERROR_SECURE_UUID_LOAD          -10022

#define ERROR_SIGN                      -10030
#define ERROR_SIGN2                     -10031
#define ERROR_ENCODING_PROOF            -10032
#define ERROR_DECODING_PROOF            -10033
#define ERROR_NOT_SET_PROOF             -10034
#define ERROR_SIGN3                     -10035

#define ERROR_TOKEN_INIT                -10040
#define ERROR_EXPORT_TOKEN              -10041
#define ERROR_IMPORT_TOKEN              -10042
#define ERROR_VERIFY_TOKEN_DATA         -10043
#define ERROR_ENCODE_TOKEN              -10044
#define ERROR_DECODE_TOKEN              -10045

#define ERROR_RELAY_CREATE_KEYPAIR          -10050
#define ERROR_RELAY_PUBLIC_KEY              -10051
#define ERROR_RELAY_GENERATE_ENCRYPT_KEY    -10052
#define ERROR_RELAY_ENCRYPT_TOKEN           -10053
#define ERROR_RELAY_ENCRYPT_DATA            -10054
#define ERROR_RELAY_ENCRYPT_KEY             -10055
#define ERROR_RELAY_INVALID_TOKEN           -10056
#define ERROR_RELAY_DECRYPT_KEY             -10057
#define ERROR_RELAY_DECRYPT_TOKEN           -10058
#define ERROR_RELAY_DECRYPT_DATA            -10059
#define ERROR_RELAY_DELETE_KEYPAIR          -10060


#endif /* SafetokenError_h */
