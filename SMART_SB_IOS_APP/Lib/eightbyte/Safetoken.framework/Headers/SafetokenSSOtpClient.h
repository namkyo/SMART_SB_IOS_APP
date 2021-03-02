//
//  SafetokenSSOtpClient.h
//  Safetoken
//
//  Created by KimMinSu on 17/04/2019.
//  Copyright © 2019 8byte. All rights reserved.
//

#ifndef SafetokenSSOtpClient_h
#define SafetokenSSOtpClient_h

@class SafetokenRef;
@class SafetokenProof;
@protocol SafetokenStoreDelegate;

@interface SafetokenSSOtpClient : NSObject

+ (instancetype)sharedInstance;

- (instancetype)initWithTokenStore:(id<SafetokenStoreDelegate>) delegate
                          keyAlias:(NSString *)keyAlias
                      uuidKeyAlias:(NSString *)uuidKeyAlias;

// store
- (BOOL)storeTokenWithEncodedMessage:(NSString *)em
                               error:(NSError **)error;

// token
- (SafetokenRef *)getToken;
- (BOOL)isExistToken:(NSError **)error;
- (BOOL)removeToken:(NSError **)error;

// sign
- (SafetokenProof *)signWithRandom:(NSString *)rnd
                             error:(NSError **)error;

- (SafetokenProof *)signWithMessage:(NSString *)msg
                                rnd:(NSString *)rnd
                              error:(NSError **)error;

- (SafetokenProof *)signDataWithMessage:(NSData *)msg
                                    rnd:(NSData *)rnd
                                  error:(NSError **)error;

// import/export
- (NSString *)exportToken;
- (NSString *)importToken:(NSString *)tokenString;
- (NSString *)importTokenWithPin:(NSData *)pin orgPin:(NSData *)orgPin tokenString:(NSString *)tokenString;

@end

#endif /* SafetokenSSOtpClient_h */
