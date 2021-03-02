//
//  Util.m
//  fdsSample
//
//  Created by 김명호_맥북 on 2019/12/19.
//  Copyright © 2019 김명호_맥북. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (NSString*) getUUID : (NSString *) identifier
{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:identifier accessGroup:nil];
    NSString *uuid = [wrapper objectForKey:(__bridge id)(kSecAttrAccount)];
    if( uuid == nil || uuid.length == 0)
    {
        // if there is not UUID in keychain, make UUID and save it.
        CFUUIDRef uuidRef = CFUUIDCreate(NULL);
        CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
        CFRelease(uuidRef);
        uuid = [NSString stringWithString:(__bridge NSString *) uuidStringRef];
        CFRelease(uuidStringRef);
        // save UUID in keychain
        [wrapper setObject:uuid forKey:(__bridge id)(kSecAttrAccount)];
    }
    return uuid;

}


@end
