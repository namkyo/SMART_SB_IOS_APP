//
//  NCCommon.h
//  PowerStudy
//
//  Created by Dong Hyun Shin on 09. 04. 03.
//  Copyright 2009 Neoclip. All rights reserved.
//

//#import <Foundation/Foundation.h>

@interface NCCommon : NSObject {

}

+(NSString *)bundlePath:(NSString*)file ext:(NSString*)ext;
+(NSString *)bundlePath:(NSString*)filename;
+(NSString *)documentPath;
+(NSString *)documentPath:(NSString*)filename;
+(void)moveToDocument:(NSString*)filename;

+(BOOL)isThisPhone; //added ver2.0.0
@end
