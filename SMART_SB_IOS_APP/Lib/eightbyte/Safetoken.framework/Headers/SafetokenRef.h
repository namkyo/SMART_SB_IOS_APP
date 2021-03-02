//
//  SafetokenObject.h
//  Safetoken
//
//  Created by KimMinSu on 26/02/2019.
//  Copyright © 2019 8byte. All rights reserved.
//

#ifndef SafetokenObject_h
#define SafetokenObject_h

#define DEFAULT_ORGANIZATION     @"default"

@interface SafetokenRef : NSObject

@property (nonatomic, strong, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSString *tokenHash;
@property (nonatomic, strong, readonly) NSString *uid;
@property (nonatomic, strong, readonly) NSString *organization;
@property (nonatomic, strong, readonly) NSString *duid;
@property (nonatomic, strong, readonly) NSString *data;
@property (nonatomic, assign, readonly) int version;
@property (nonatomic, assign, readonly) BOOL bindBiometric;
@property (nonatomic, assign, readonly) BOOL bindPattern;

- (instancetype)initWithIdentifier:(NSString *)identifier
                              duid:(NSString *)duid
                              data:(NSString *)data
                           version:(int)version
                     bindBiometric:(BOOL)bindBiometric
                       bindPattern:(BOOL)bindPattern;

- (BOOL)verifyData:(NSError **)error;

@end

#endif /* SafetokenObject_h */
