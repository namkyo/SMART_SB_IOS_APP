//
//  Logger.h
//  CertmanagerLibrary
//
//  Created by choi sung hoon on 12. 2. 13..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "KSdefine.h"

@interface Logger : NSObject  {
}

+ (void) setLogOn: (BOOL)logOn;
+ (void) print: (NSString*) message, ...;
+ (void) printWithTitle:(NSString*)title message:(NSString*) message, ...;
+ (void) printCString: (char*) message, ...;
+ (void) printBin: (NSString*)title bytes:(char *)bytes len:(int)len;
+ (void) writeToFile:(NSString *)aFileName data:(char *)aData dataLen:(int)dataLen;

@end
