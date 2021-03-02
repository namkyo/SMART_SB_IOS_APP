//
//  SafetokenBiometricAuth.h
//  safetoken-biometric
//
//  Created by KimMinSu on 14/03/2019.
//  Copyright © 2019 8BYTE. All rights reserved.
//

#ifndef SafetokenBiometricAuth_h
#define SafetokenBiometricAuth_h

@class SafetokenRef;
@class SafetokenProof;
@protocol SafetokenClientDelegate;

typedef enum BiometryType : NSInteger {
    BiometryTypeNone, BiometryTypeTouchId, BiometryTypeFaceId, BiometryTypeAny
} BiometryType;

typedef void (^OnBiometricAuthFail)(NSInteger code, NSString * _Nonnull errMsg, int count);
typedef void (^OnStoreBiometricCredentialComplete)(void);
typedef void (^OnGenerateSignComplete)(SafetokenProof * _Nonnull tnp);
typedef void (^OnRemoveBiometricCredentialComplete)(void);

@interface SafetokenBiometricAuth : NSObject

// 생체인증 종류 확인
- (BiometryType)getBiometricType:(NSError *_Nullable*_Nullable)error;

// 생체인증 정보 저장
- (void)storeCredentialWithToken:(SafetokenRef *_Nonnull)tokenRef
                     tokenClient:(id<SafetokenClientDelegate>_Nonnull)tokenClient
                      credential:(NSString *_Nonnull)credential
                operationMessage:(NSString *_Nullable)operationMsg
                      onComplete:(OnStoreBiometricCredentialComplete _Nullable)onComplete
                          onFail:(OnBiometricAuthFail _Nullable)onFail;

- (void)storeCredentialDataWithToken:(SafetokenRef *_Nonnull)tokenRef
                         tokenClient:(id<SafetokenClientDelegate>_Nonnull)tokenClient
                          credential:(NSData *_Nonnull)credential
                    operationMessage:(NSString *_Nullable)operationMsg
                          onComplete:(OnStoreBiometricCredentialComplete _Nullable)onComplete
                              onFail:(OnBiometricAuthFail _Nullable)onFail;

// 생체인증으로 전자서명 수행
- (void)generateSignWithToken:(SafetokenRef *_Nonnull)tokenRef
                  tokenClient:(id<SafetokenClientDelegate>_Nonnull)tokenClient
                          rnd:(NSString *_Nonnull)rnd
                          msg:(NSString *_Nonnull)msg
             operationMessage:(NSString *_Nullable)operationMsg
                   onComplete:(OnGenerateSignComplete _Nonnull)onComplete
                       onFail:(OnBiometricAuthFail _Nullable)onFail;

- (void)generateSignDataWithToken:(SafetokenRef *_Nonnull)tokenRef
                      tokenClient:(id<SafetokenClientDelegate>_Nonnull)tokenClient
                              rnd:(NSData *_Nonnull)rnd
                              msg:(NSData *_Nonnull)msg
                 operationMessage:(NSString *_Nullable)operationMsg
                       onComplete:(OnGenerateSignComplete _Nonnull)onComplete
                           onFail:(OnBiometricAuthFail _Nullable)onFail;

// 생체인증 확인 후 생체인증 정보 삭제
- (void)removeCredentialWithToken:(SafetokenRef *_Nonnull)tokenRef
                      tokenClient:(id<SafetokenClientDelegate>_Nonnull)tokenClient
                 operationMessage:(NSString *_Nullable)operationMsg
                       onComplete:(OnRemoveBiometricCredentialComplete _Nullable)onComplete
                           onFail:(OnBiometricAuthFail _Nullable)onFail;

// 오류 횟수 확인
- (int)getFailCountWithToken:(SafetokenRef * _Nonnull)tokenRef
                 tokenClient:(id<SafetokenClientDelegate> _Nonnull)tokenClient;

@end

#endif /* SafetokenBiometricAuth_h */
