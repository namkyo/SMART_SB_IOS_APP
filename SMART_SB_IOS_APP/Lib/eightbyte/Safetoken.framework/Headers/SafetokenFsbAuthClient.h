//
//  SafetokenFsbAuthClient.h
//  Safetoken
//
//  Created by KimMinSu on 17/05/2019.
//  Copyright © 2019 8byte. All rights reserved.
//

#ifndef SafetokenFsbAuthClient_h
#define SafetokenFsbAuthClient_h

#import "SafetokenClientDelegate.h"

@class SafetokenRef;
@class SafetokenProof;

@interface SafetokenFsbAuthClient : NSObject <SafetokenClientDelegate>

+ (instancetype)sharedInstance;

// Store
- (BOOL)storeTokenWithEncodedMessage:(NSString *)em
                                 pin:(NSString *)pin
                               error:(NSError **)error;

// Token
- (SafetokenRef *)getTokenWithUid:(NSString *)uid
                     organization:(NSString *)organization;

- (BOOL)isExistTokenWithUid:(NSString *)uid
               organization:(NSString *)organization
                      error:(NSError **)error;

- (BOOL)removeTokenWithUid:(NSString *)uid
              organization:(NSString *)organization
                     error:(NSError **)error;

- (BOOL)isExistToken:(SafetokenRef *)tokenRef
               error:(NSError **)error;

- (BOOL)removeToken:(SafetokenRef *)tokenRef
              error:(NSError **)error;

// List
- (NSArray *)getUidListWithOrganization:(NSString *)organization;
- (NSArray *)getOrganizationList;
- (NSArray *)getTokenListWithOrganization:(NSString *)organization;
- (NSArray *)getTokenList;

// Sign
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

// Biometric
- (BOOL)storeBiometricCredentialWithToken:(SafetokenRef *)tokenRef credential:(NSData *)credential;
- (NSData *)loadBiometricCredentialWithToken:(SafetokenRef *)tokenRef;
- (BOOL)removeBiometricCredentialWithToken:(SafetokenRef *)tokenRef;

// Pattern
- (BOOL)storePatternCredentialWithToken:(SafetokenRef *)tokenRef credential:(NSData *)credential;
- (NSData *)loadPatternCredentialWithToken:(SafetokenRef *)tokenRef;
- (BOOL)removePatternCredentialWithToken:(SafetokenRef *)tokenRef;

@end

#endif /* SafetokenFsbAuthClient_h */
