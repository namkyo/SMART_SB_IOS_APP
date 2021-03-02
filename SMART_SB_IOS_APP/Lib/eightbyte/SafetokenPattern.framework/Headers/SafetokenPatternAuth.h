//
//  SafetokenPatternAuth.h
//  SafetokenPattern
//
//  Created by KimMinSu on 28/03/2019.
//  Copyright © 2019 8BYTE. All rights reserved.
//

#ifndef SafetokenPatternAuth_h
#define SafetokenPatternAuth_h

@class SafetokenRef;
@class SafetokenProof;
@protocol SafetokenClientDelegate;

typedef void (^OnPatternAuthFail)(int code, NSString * _Nonnull errMsg, int count);
typedef void (^OnStorePatternCredentialComplete)(void);
typedef void (^OnGenerateSignComplete)(SafetokenProof * _Nonnull tnp);
typedef void (^OnValidatePatternComplete)(NSString * _Nonnull credential);
typedef void (^OnRemovePatternCredentialComplete)(void);

@interface SafetokenPatternAuth : NSObject

// Block

- (void)storeCredentialWithToken:(SafetokenRef * _Nonnull)tokenRef
                     tokenClient:(id<SafetokenClientDelegate> _Nonnull)tokenClient
                      credential:(NSString * _Nonnull)credential
                         pattern:(NSString * _Nonnull)pattern
                      onComplete:(OnStorePatternCredentialComplete _Nullable)onComplete
                          onFail:(OnPatternAuthFail _Nullable)onFail;

- (void)generateSignWithToken:(SafetokenRef * _Nonnull)tokenRef
                  tokenClient:(id<SafetokenClientDelegate> _Nonnull)tokenClient
                          rnd:(NSString * _Nonnull)rnd
                          msg:(NSString * _Nonnull)msg
                      pattern:(NSString * _Nonnull)pattern
                    failCheck:(BOOL)failCheck
                   onComplete:(OnGenerateSignComplete _Nonnull)onComplete
                       onFail:(OnPatternAuthFail _Nullable)onFail;

- (void)generateSignDataWithToken:(SafetokenRef * _Nonnull)tokenRef
                      tokenClient:(id<SafetokenClientDelegate> _Nonnull)tokenClient
                              rnd:(NSData * _Nonnull)rnd
                              msg:(NSData * _Nonnull)msg
                          pattern:(NSString * _Nonnull)pattern
                        failCheck:(BOOL)failCheck
                       onComplete:(OnGenerateSignComplete _Nonnull)onComplete
                           onFail:(OnPatternAuthFail _Nullable)onFail;

- (void)removeCredentialWithToken:(SafetokenRef * _Nonnull)tokenRef
                      tokenClient:(id<SafetokenClientDelegate> _Nonnull)tokenClient
                          pattern:(NSString * _Nonnull)pattern
                       onComplete:(OnRemovePatternCredentialComplete _Nullable)onComplete
                           onFail:(OnPatternAuthFail _Nullable)onFail;

- (void)validatePatternWithToken:(SafetokenRef * _Nonnull)tokenRef
                     tokenClient:(id<SafetokenClientDelegate> _Nonnull)tokenClient
                         pattern:(NSString * _Nonnull)pattern
                      onComplete:(OnValidatePatternComplete _Nullable)onComplete
                          onFail:(OnPatternAuthFail _Nullable)onFail;

- (int)getFailCountWithToken:(SafetokenRef * _Nonnull)tokenRef
                 tokenClient:(id<SafetokenClientDelegate> _Nonnull)tokenClient;

// Sync

- (BOOL)storeCredentialWithToken:(SafetokenRef * _Nonnull)tokenRef
                     tokenClient:(id<SafetokenClientDelegate> _Nonnull)tokenClient
                      credential:(NSString * _Nonnull)credential
                         pattern:(NSString * _Nonnull)pattern
                           error:(NSError *_Nullable*_Nullable)error;

- (SafetokenProof *_Nullable)generateSignWithToken:(SafetokenRef * _Nonnull)tokenRef
                                       tokenClient:(id<SafetokenClientDelegate> _Nonnull)tokenClient
                                               rnd:(NSString * _Nonnull)rnd
                                               msg:(NSString * _Nonnull)msg
                                           pattern:(NSString * _Nonnull)pattern
                                         failCheck:(BOOL)failCheck
                                             error:(NSError *_Nullable*_Nullable)error;

- (SafetokenProof *_Nullable)generateSignDataWithToken:(SafetokenRef * _Nonnull)tokenRef
                                           tokenClient:(id<SafetokenClientDelegate> _Nonnull)tokenClient
                                                   rnd:(NSData * _Nonnull)rnd
                                                   msg:(NSData * _Nonnull)msg
                                               pattern:(NSString * _Nonnull)pattern
                                             failCheck:(BOOL)failCheck
                                                 error:(NSError *_Nullable*_Nullable)error;

- (BOOL)removeCredentialWithToken:(SafetokenRef * _Nonnull)tokenRef
                      tokenClient:(id<SafetokenClientDelegate> _Nonnull)tokenClient
                          pattern:(NSString * _Nonnull)pattern
                            error:(NSError *_Nullable*_Nullable)error;

- (BOOL)validatePatternWithToken:(SafetokenRef * _Nonnull)tokenRef
                     tokenClient:(id<SafetokenClientDelegate> _Nonnull)tokenClient
                         pattern:(NSString * _Nonnull)pattern
                           error:(NSError *_Nullable*_Nullable)error;
@end

#endif /* SafetokenPatternAuth_h */
