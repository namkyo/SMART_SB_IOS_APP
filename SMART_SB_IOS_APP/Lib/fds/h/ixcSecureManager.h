//
//  ixcSecureManager.h
//  E2E_Engine
//
//  Created by Ko Jaewan on 2015. 3. 25..
//  Copyright (c) 2015년 INCA Internet INC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ixcSecureManager : NSObject

+ (BOOL)initLicense:(NSString *)license andCustomID:(NSString *)customId;
+ (BOOL)initLicense:(NSString *)license andCustomID:(NSString *)customId withLog:(BOOL)log;
+ (NSString *)getMajorVersion;
+ (int)getVersion;
+ (NSString *)getVersionString;
+ (BOOL)checkJailbreak;
@end
