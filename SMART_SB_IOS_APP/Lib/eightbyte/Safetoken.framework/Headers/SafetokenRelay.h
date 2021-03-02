//
//  SafetokenRelay.h
//  Safetoken
//
//  Created by KimMinSu on 2020/05/21.
//  Copyright © 2020 8byte. All rights reserved.
//

#ifndef SafetokenRelay_h
#define SafetokenRelay_h

@class SafetokenSimpleClient;

@interface SafetokenRelay : NSObject

+ (NSString *)createImportKeyPair:(NSError **)error;
+ (void)deleteImportKeyPair:(NSError **)error;

+ (NSString *)exportTokenWithPublicKey:(NSString *)publicKey
                            identifier:(NSString *)identifier
                           exportToken:(NSString *)exportToken
                                  data:(NSString *)data
                                 error:(NSError **)error;


+ (NSString *)getIdentifier:(NSString *)em error:(NSError **)error;
+ (NSString *)getData:(NSString *)em error:(NSError **)error;
+ (NSString *)getImportToken:(NSString *)em error:(NSError **)error;

@end


#endif /* SafetokenRelay_h */
