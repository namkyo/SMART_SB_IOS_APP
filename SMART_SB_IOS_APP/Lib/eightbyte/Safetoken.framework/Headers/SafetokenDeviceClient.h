//
//  SafetokenDeviceClient.h
//  Safetoken
//
//  Created by KimMinSu on 26/02/2019.
//  Copyright © 2019 8byte. All rights reserved.
//

#ifndef SafetokenDeviceClient_h
#define SafetokenDeviceClient_h

@class SafetokenRef;
@class SafetokenProof;

@interface SafetokenDeviceClient : NSObject

+ (instancetype)sharedInstance;

// Device Hash
- (NSString *)getDeviceHash;

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

@end

#endif /* SafetokenDeviceClient_h */
