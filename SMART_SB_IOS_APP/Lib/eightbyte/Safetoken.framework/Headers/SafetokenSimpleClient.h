//
//  SafetokenSimpleClient.h
//  Safetoken
//
//  Created by KimMinSu on 26/02/2019.
//  Copyright © 2019 8byte. All rights reserved.
//

#ifndef SafetokenSimpleClient_h
#define SafetokenSimpleClient_h

#import "SafetokenClientDelegate.h"

@class SafetokenRef;
@class SafetokenProof;
@protocol SafetokenStoreDelegate;

@interface SafetokenSimpleClient : NSObject <SafetokenClientDelegate>

@property (nonatomic, strong) SafetokenProof *tnpForSign2;
@property (nonatomic, strong) SafetokenProof *msgForSign2;
@property (nonatomic, strong) SafetokenProof *tnpForSign3;

+ (instancetype)sharedInstance;

// init
- (instancetype)initWithTokenStore:(id<SafetokenStoreDelegate>) delegate
                          keyAlias:(NSString *)keyAlias;

// store
- (BOOL)storeTokenWithEncodedMessage:(NSString *)em
                                 pin:(NSString *)pin
                               error:(NSError **)error;

// token
- (SafetokenRef *)getToken;
- (BOOL)isExistToken:(NSError **)error;
- (BOOL)removeToken:(NSError **)error;

// sign
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

- (SafetokenProof *)signWithRandom:(NSString *)rnd
                               pin:(NSString *)pin
                             error:(NSError **)error;

- (SafetokenProof *)signWithMessage:(NSString *)msg
                                rnd:(NSString *)rnd
                                pin:(NSString *)pin
                              error:(NSError **)error;

- (SafetokenProof *)signDataWithMessage:(NSData *)msg
                                    rnd:(NSData *)rnd
                                    pin:(NSData *)pin
                                  error:(NSError **)error;

// Sign2
- (SafetokenProof *)sign2WithString:(NSString *)proof
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
- (NSString *)exportToken:(NSString *)pin error:(NSError **)error;
- (NSString *)importToken:(NSString *)encToken pin:(NSString *)pin error:(NSError **)error;

// Biometirc Credential
- (BOOL)storeBiometricCredentialWithToken:(SafetokenRef *)tokenRef credential:(NSData *)credential;
- (NSData *)loadBiometricCredentialWithToken:(SafetokenRef *)tokenRef;
- (BOOL)removeBiometricCredentialWithToken:(SafetokenRef *)tokenRef;

// Pattern Credential
- (BOOL)storePatternCredentialWithToken:(SafetokenRef *)tokenRef credential:(NSData *)credential;
- (NSData *)loadPatternCredentialWithToken:(SafetokenRef *)tokenRef;
- (BOOL)removePatternCredentialWithToken:(SafetokenRef *)tokenRef;

@end

#endif /* SafetokenSimpleClient_h */
