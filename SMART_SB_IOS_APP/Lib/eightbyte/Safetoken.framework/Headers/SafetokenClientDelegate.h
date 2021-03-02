//
//  SafetokenClientDelegate.h
//  Safetoken
//
//  Created by KimMinSu on 21/03/2019.
//  Copyright © 2019 8byte. All rights reserved.
//

#ifndef SafetokenClientDelegate_h
#define SafetokenClientDelegate_h

@class SafetokenProof;
@class SafetokenRef;

@protocol SafetokenClientDelegate

@required
- (SafetokenProof *)signWithToken:(SafetokenRef *)tokenRef rnd:(NSString *)rnd pin:(NSString *)pin msg:(NSString *)msg error:(NSError **)error;
- (SafetokenProof *)signDataWithToken:(SafetokenRef *)tokenRef rnd:(NSData *)rnd pin:(NSData *)pin msg:(NSData *)msg error:(NSError **)error;
- (BOOL)storeBiometricCredentialWithToken:(SafetokenRef *)tokenRef credential:(NSData *)credential;
- (NSData *)loadBiometricCredentialWithToken:(SafetokenRef *)tokenRef;
- (BOOL)removeBiometricCredentialWithToken:(SafetokenRef *)tokenRef;

- (BOOL)storePatternCredentialWithToken:(SafetokenRef *)tokenRef credential:(NSData *)credential;
- (NSData *)loadPatternCredentialWithToken:(SafetokenRef *)tokenRef;
- (BOOL)removePatternCredentialWithToken:(SafetokenRef *)tokenRef;
@end

#endif /* SafetokenClientDelegate_h */
