//
//  SafetokenClient.h
//  SafetokenClient 인터페이스
//
//  Created by KimMinSu on 04/09/2018.
//  Copyright © 2018 8byte. All rights reserved.
//

#ifndef SafetokenClient_h
#define SafetokenClient_h

#import "SafetokenClientDelegate.h"

@class SecureUUID;
@class SafetokenProof;
@class SafetokenRef;
@protocol SafetokenStoreDelegate;

@interface SafetokenClient : NSObject <SafetokenClientDelegate>

@property (nonatomic, strong, readonly) SecureUUID *secureUUID;
@property (nonatomic, strong) id<SafetokenStoreDelegate> storeDelegate;

@property (nonatomic, strong) SafetokenProof *tnpForSign2;
@property (nonatomic, strong) SafetokenProof *msgForSign2;
@property (nonatomic, strong) SafetokenProof *tnpForSign3;

+ (instancetype)sharedInstance;
- (instancetype)init;
- (instancetype)initWithTokenStore:(id<SafetokenStoreDelegate>) delegate
                          keyAlias:(NSString *)keyAlias;

// uid List
- (NSArray *)getUidList;
- (NSArray *)getUidListWithOrganization:(NSString *)organization;
- (NSArray *)getOrganizationList;

// store
- (BOOL)storeTokenWithEncodedMessage:(NSString *)em
                                 pin:(NSString *)pin
                               error:(NSError **)error;

// Functions for default organization
- (SafetokenRef *)getTokenWithUid:(NSString *)uid;

- (BOOL)isExistTokenWithUid:(NSString *)uid
                      error:(NSError **)error;

- (BOOL)removeTokenWithUid:(NSString *)uid
                     error:(NSError **)error;

- (SafetokenProof *)signWithUid:(NSString *)uid
                            rnd:(NSString *)rnd
                            pin:(NSString *)pin
                          error:(NSError **)error;

- (SafetokenProof *)signWithUid:(NSString *)uid
                            rnd:(NSString *)rnd
                            pin:(NSString *)pin
                            msg:(NSString *)msg
                          error:(NSError **)error;

// Functions for organization
- (SafetokenRef *)getTokenWithUid:(NSString *)uid
                        organization:(NSString *)organization;

- (BOOL)isExistTokenWithUid:(NSString *)uid
               organization:(NSString *)organization
                      error:(NSError **)error;

- (BOOL)removeTokenWithUid:(NSString *)uid
              organization:(NSString *)organization
                     error:(NSError **)error;

- (SafetokenProof *)signWithUid:(NSString *)uid
                   organization:(NSString *)organization
                            rnd:(NSString *)rnd
                            pin:(NSString *)pin
                          error:(NSError **)error;

- (SafetokenProof *)signWithUid:(NSString *)uid
                   organization:(NSString *)organization
                            rnd:(NSString *)rnd
                            pin:(NSString *)pin
                            msg:(NSString *)msg
                          error:(NSError **)error;

- (SafetokenProof *)signDataWithUid:(NSString *)uid
                       organization:(NSString *)organization
                                rnd:(NSData *)rnd
                                pin:(NSData *)pin
                                msg:(NSData *)msg
                              error:(NSError **)error;

// Functions with SafetokenObject
- (BOOL)isExistToken:(SafetokenRef *)tokenRef
               error:(NSError **)error;

- (BOOL)removeToken:(SafetokenRef *)tokenRef
              error:(NSError **)error;

- (NSArray *)getTokenListWithOrganization:(NSString *)organization;

- (NSArray *)getTokenList;

- (SafetokenProof *)signWithToken:(SafetokenRef *)tokenRef
                              rnd:(NSString *)rnd
                              pin:(NSString *)pin
                            error:(NSError **)error;

- (SafetokenProof *)signWithToken:(SafetokenRef *)tokenRef
                              rnd:(NSString *)rnd
                              pin:(NSString *)pin
                              msg:(NSString *)msg
                            error:(NSError **)error;

- (SafetokenProof *)signDataWithToken:(SafetokenRef *)tokenRef
                                  rnd:(NSData *)rnd
                                  pin:(NSData *)pin
                                  msg:(NSData *)msg
                                error:(NSError **)error;

// Sign2
- (SafetokenProof *)sign2WithString:(NSString *)em
                           exponent:(NSString *)exponent
                              error:(NSError **)error;

- (SafetokenProof *)sign2WithData:(NSString *)em
                         exponent:(NSData *)exponent
                            error:(NSError **)error;

- (SafetokenProof *)sign2WithProof:(SafetokenProof *)tnp
                          exponent:(NSString *)exponent
                             error:(NSError **)error;

- (SafetokenProof *)sign2DataWithProof:(SafetokenProof *)tnp
                              exponent:(NSData *)exponent
                                 error:(NSError **)error;

- (SafetokenProof *)sign2WithExponent:(NSString *)exponent
                                error:(NSError **)error;

- (SafetokenProof *)sign2WithExponentData:(NSData *)exponent
                                    error:(NSError **)error;

// Sign3
- (SafetokenProof *)sign3WithProof:(SafetokenProof *)tnp
                               msg:(NSString *)msg
                             error:(NSError **)error;

- (SafetokenProof *)sign3DataWithProof:(SafetokenProof *)tnp
                                   msg:(NSData *)msg
                                 error:(NSError **)error;

- (SafetokenProof *)sign3WithMessage:(NSString *)msg
                                error:(NSError **)error;

- (SafetokenProof *)sign3WithMessageData:(NSData *)msg
                                   error:(NSError **)error;


// import/export
- (NSString *)exportToken:(SafetokenRef *)tokenRef
                      pin:(NSString *)pin
                    error:(NSError **)error;

- (NSString *)exportTokenWithUid:(NSString *)uid
                    organization:(NSString *)organization
                             pin:(NSString *)pin
                           error:(NSError **)error;

- (NSString *)exportTokenWithUid:(NSString *)uid
                             pin:(NSString *)pin
                           error:(NSError **)error;

- (NSString *)importToken:(NSString *)encToken
                      pin:(NSString *)pin
                    error:(NSError **)error;

// Biometric Credential
- (BOOL)storeBiometricCredentialWithToken:(SafetokenRef *)tokenRef
                               credential:(NSData *)credential;

- (NSData *)loadBiometricCredentialWithToken:(SafetokenRef *)tokenRef;

- (BOOL)removeBiometricCredentialWithToken:(SafetokenRef *)tokenRef;

// Pattern Credential
- (BOOL)storePatternCredentialWithToken:(SafetokenRef *)tokenRef
                               credential:(NSData *)credential;

- (NSData *)loadPatternCredentialWithToken:(SafetokenRef *)tokenRef;

- (BOOL)removePatternCredentialWithToken:(SafetokenRef *)tokenRef;

@end

#endif /* SafetokenClient_h */
