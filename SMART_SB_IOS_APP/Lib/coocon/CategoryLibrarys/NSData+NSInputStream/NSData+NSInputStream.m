//
//  NSData+NSInputStream.m
//  JavaScriptSample
//
//  Created by 류재욱 on 2016. 1. 8..
//  Copyright © 2016년 류재욱. All rights reserved.
//

#import "NSData+NSInputStream.h"

#define BUFSIZE 65536U


@implementation NSData (NSInputStream)


+(NSData *)dataWithContentsOfStream:(NSInputStream *)input initialCapacity:(NSUInteger)capacity error:(NSError **)error {
    size_t bufsize = MIN(BUFSIZE, capacity);
    uint8_t * buf = malloc(bufsize);
    if (buf == NULL) {
        if (error) {
            *error = [NSError errorWithDomain:NSPOSIXErrorDomain code:ENOMEM userInfo:nil];
        }
        return nil;
    }
    
    NSMutableData* result = capacity == NSUIntegerMax ? [NSMutableData data] : [NSMutableData dataWithCapacity:capacity];
    @try {
        while (true) {
            NSInteger n = [input read:buf maxLength:bufsize];
            if (n < 0) {
                result = nil;
                if (error) {
                    *error = [NSError errorWithDomain:NSPOSIXErrorDomain code:errno userInfo:nil];
                }
                break;
            }
            else if (n == 0) {
                break;
            }
            else {
                [result appendBytes:buf length:n];
            }
        }
    }
    @catch (NSException * exn) {
        NSLog(@"Caught exception writing to file: %@", exn);
        result = nil;
        if (error) {
            *error = [NSError errorWithDomain:NSPOSIXErrorDomain code:EIO userInfo:nil];
        }
    }
    
    free(buf);
    return result;
}

@end
