//
//  SafetokenProof.h
//  Safetoken
//
//  Created by KimMinSu on 25/02/2019.
//  Copyright © 2019 8byte. All rights reserved.
//

#ifndef SafetokenProof_h
#define SafetokenProof_h

@interface SafetokenProof : NSObject

@property (nonatomic, strong, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSString *random;
@property (nonatomic, strong, readonly) NSData *hashedMsg;
@property (nonatomic, strong, readonly) NSData *signature;
@property (nonatomic, strong, readonly) NSData *remainder;
@property (nonatomic, assign, readonly) int version;
@property (nonatomic, strong, readonly) NSString *encodedMessage;
@property (nonatomic, strong, readonly) NSData *tnpData;

- (instancetype)initWithIdentifier:(NSString *)identifier
                            random:(NSString *)random
                         hashedMsg:(NSData *)hashedMsg
                         signature:(NSData *)signature
                         remainder:(NSData *)remainder
                           version:(int)version
                    encodedMessage:(NSString *)em
                        tokenProof:(NSData *)tnpData;

- (NSString *)getOtpStringWithDigit:(int)digit;

@end


#endif /* SafetokenProof_h */
