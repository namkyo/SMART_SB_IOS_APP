//
//  UIViewController+KeySharpProviderUtil.m
//  SMART_SB_APP_IOS
//
//  Created by 최지수 on 2021/02/22.
//

#import <Foundation/Foundation.h>
#import "CertManager.h"
#import "KSutil.h"
#import "SecureData.h"

@interface KeySharpProviderUtil : NSObject
@end

@implementation KeySharpProviderUtil

- (NSString *) koscomSign:(int) idx
                password:(NSString*) password
              sourceData:(NSString*) signSource //서명원문
                 manager:(CertManager*) manager {
    
    //char signResult[4096] = {0x00,};
    char signResult[50000] = {0x00,};
    int ret = 0;
    NSString *result = @"";
    
    NSData* signSourceData = [signSource dataUsingEncoding: NSUTF8StringEncoding];
    ProtectedData *pwd = [[SecureData alloc]
                          initWithData: password.UTF8String
                          length: password.length];

    //일반 코스콤서명
//    ret = [manager koscomSign_S:idx
//                    password:pwd
//                  signSource:signSourceData
//                  signResult:signResult];
    
    //cms 서명
    ret = [ manager cmsSign_S:idx
                     password:pwd
                   signSource:signSourceData
                  signingTime:nil
                   signResult:signResult];
    
    if(ret > 0) {
        ks_uint8 *encodedSign = (ks_uint8 *)malloc(ret*2+1);
        memset(encodedSign, 0x00, ret*2+1);
        KSH_Msg_Encoding(encodedSign, signResult, ret, KSH_ENCODING_BASE64);
        result = [NSString stringWithUTF8String:encodedSign];
        free(encodedSign);
    }
    else if(ret == KS_INVALID_PASSWORD)
        result = @"인증서 암호가 일치하지 않습니다.";
    else if(ret == KS_ERR_SIGN_FAIL)
        result = @"전자서명이 실패하였습니다.";
    else
        result = @"서명 실패";
    return result;
}

- (NSString *) getRandom:(int) idx
                password:(NSString*) password
                 manager: (CertManager*) manager{

    ks_uint8 hexRand[1024] = {0x00, };
    ks_uint8 b64Rand[1024] = {0x00, };
    
    NSString *result = @"";
    
    ProtectedData *pwd = [[SecureData alloc]
                          initWithData: password.UTF8String
                          length: password.length];
    
    NSData* randomVal = [manager getRandomFromKey_S:idx
                       password:pwd];
    
    if (randomVal == nil) {
        result = @"Random 추출 실패";
        
    } else {
        KSH_Msg_Encoding(hexRand, randomVal.bytes, randomVal.length, KSH_ENCODING_HEXUP);
        KSH_Msg_Encoding(b64Rand, randomVal.bytes, randomVal.length, KSH_ENCODING_BASE64);
        NSMutableString *msg = [NSMutableString stringWithFormat:@"Random 추출 성공(%d bytes)\n", randomVal.length];
        result =  [NSString stringWithUTF8String:b64Rand];
    }

    return result;
}
@end
