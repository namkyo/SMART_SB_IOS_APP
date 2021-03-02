//
//  SafetokenSSClient.h
//  Safetoken
//
//  Created by KimMinSu on 17/04/2019.
//  Copyright © 2019 8byte. All rights reserved.
//

#ifndef SafetokenSSClient_h
#define SafetokenSSClient_h


#import "SafetokenClientDelegate.h"

@class SafetokenRef;
@class SafetokenProof;
@protocol SafetokenStoreDelegate;

@interface SafetokenSSClient : NSObject <SafetokenClientDelegate>

@property (nonatomic, retain) SafetokenProof *tnpForSign2;
@property (nonatomic, retain) NSString *msgForSign2;

+ (instancetype)sharedInstance;

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

- (SafetokenProof *)signWithRandom:(NSString *)rnd
                             error:(NSError **)error;

- (SafetokenProof *)signWithMessage:(NSString *)msg
                                rnd:(NSString *)rnd
                              error:(NSError **)error;

- (SafetokenProof *)signDataWithMessage:(NSData *)msg
                                    rnd:(NSData *)rnd
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

- (void)setSafetokenProofForSign2:(SafetokenProof *)tnp;
- (void)setSafetokenProofMsgForSign2:(NSString *)msg;
- (SafetokenProof *)sign2WithExponent:(NSString *)exponent
                                error:(NSError **)error;

// Biometirc Credential
- (BOOL)storeBiometricCredentialWithToken:(SafetokenRef *)tokenRef credential:(NSData *)credential;
- (NSData *)loadBiometricCredentialWithToken:(SafetokenRef *)tokenRef;
- (BOOL)removeBiometricCredentialWithToken:(SafetokenRef *)tokenRef;

// Pattern Credential
- (BOOL)storePatternCredentialWithToken:(SafetokenRef *)tokenRef credential:(NSData *)credential;
- (NSData *)loadPatternCredentialWithToken:(SafetokenRef *)tokenRef;
- (BOOL)removePatternCredentialWithToken:(SafetokenRef *)tokenRef;

// Migration from V2
- (BOOL)isExistV2Token:(NSString *)v2Dir;
- (BOOL)removeV2Token:(NSString *)v2Dir;
- (BOOL)importFromV2Token:(NSString *)v2Dir pwd:(NSData *)pwd error:(NSError **)error;

@end

#endif /* SafetokenSSClient_h */
