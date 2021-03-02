//
//  Util.h
//  SecureData
//
//  Created by shield on 2017. 7. 17..
//  Copyright © 2017년 sungduk kim. All rights reserved.
//

#ifndef CertUtil_h
#define CertUtil_h

#include <stdlib.h>

#ifdef __cplusplus
extern "C" {
#endif
    unsigned char SecureDataForDigit(int i, int j, int mode);
    int SecureDataHEXEncode(unsigned char* output, unsigned char* input, int inLen, int mode);
    int SecureDataHEXDecode(unsigned char* output, unsigned char* input, int inlen);
    
    int SecureDataBASE64Encode(unsigned char *output, unsigned char *input, int length);
    int SecureDataBASE64Decode(unsigned char *output, unsigned char *input, int length);
    
#ifdef __cplusplus
}
#endif


#endif /* CertUtil_h */
