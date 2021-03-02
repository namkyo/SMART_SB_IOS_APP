//
//  SafetokenOtpRef.h
//  Safetoken
//
//  Created by KimMinSu on 07/05/2019.
//  Copyright © 2019 8byte. All rights reserved.
//

#ifndef SafetokenOtpRef_h
#define SafetokenOtpRef_h

@class SafetokenRef;

@interface SafetokenOtpRef : NSObject

@property (nonatomic, strong, readonly) SafetokenRef *tokenRef;
@property (nonatomic, strong, readonly) NSString *qualifiedName;
@property (nonatomic, strong, readonly, getter = getUid) NSString *uid;
@property (nonatomic, strong, readonly, getter = getOrganization) NSString *organization;
@property (nonatomic, strong, readonly, getter = getDuid) NSString *duid;
@property (nonatomic, strong, readonly, getter = getData) NSString *data;
@property (nonatomic, assign, readonly, getter = getVersion) int version;

- (instancetype)initWithTokenRef:(SafetokenRef *)tokenRef qualifiedName:(NSString *)qualifiedName;

@end

#endif /* SafetokenOtpRef_h */
