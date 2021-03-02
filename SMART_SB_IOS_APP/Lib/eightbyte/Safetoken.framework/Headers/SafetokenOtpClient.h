//
//  SafetokenOtpClient.h
//  Safetoken
//
//  Created by KimMinSu on 07/05/2019.
//  Copyright © 2019 8byte. All rights reserved.
//

#ifndef SafetokenOtpClient_h
#define SafetokenOtpClient_h

#import "SafetokenClientDelegate.h"

@class SafetokenRef;
@class SafetokenOtpRef;
@class SafetokenProof;

@interface SafetokenOtpClient : NSObject <SafetokenClientDelegate>

+ (instancetype)sharedInstance;

// Store
- (BOOL)storeTokenWithEncodedMessage:(NSString *)em
                       qualifiedName:(NSString *)qualifiedName
                               error:(NSError **)error;

// Token
- (SafetokenOtpRef *)getTokenWithUid:(NSString *)uid
                        organization:(NSString *)organization
                       qualifiedName:(NSString *)qualifiedName;

- (BOOL)isExistTokenWithUid:(NSString *)uid
               organization:(NSString *)organization
              qualifiedName:(NSString *)qualifiedName
                      error:(NSError **)error;

- (BOOL)removeTokenWithUid:(NSString *)uid
              organization:(NSString *)organization
             qualifiedName:(NSString *)qualifiedName
                     error:(NSError **)error;

- (NSArray *)getQualifiedNameList;
- (NSArray *)getOtpTokenList:(NSString *)organization qualifiedName:(NSString *)qualifiedName;
- (NSArray *)getOtpTokenList:(NSString *)qualifiedName;
- (NSArray *)getOtpTokenList;

// Sign
- (SafetokenProof *)signWithToken:(SafetokenRef *)tokenRef
                              rnd:(NSString *)rnd
                    qualifiedName:(NSString *)qualifiedName
                            error:(NSError **)error;

- (SafetokenProof *)signWithToken:(SafetokenRef *)tokenRef
                              rnd:(NSString *)rnd
                              msg:(NSString *)msg
                    qualifiedName:(NSString *)qualifiedName
                            error:(NSError **)error;

- (SafetokenProof *)signDataWithToken:(SafetokenRef *)tokenRef
                                  rnd:(NSData *)rnd
                                  msg:(NSData *)msg
                        qualifiedName:(NSString *)qualifiedName
                                error:(NSError **)error;

@end


#endif /* SafetokenOtpClient_h */
