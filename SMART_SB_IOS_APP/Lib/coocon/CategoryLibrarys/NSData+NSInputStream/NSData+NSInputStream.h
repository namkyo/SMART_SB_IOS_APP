//
//  NSData+NSInputStream.h
//  JavaScriptSample
//
//  Created by 류재욱 on 2016. 1. 8..
//  Copyright © 2016년 류재욱. All rights reserved.
//

#ifndef NSData_NSInputStream_h
#define NSData_NSInputStream_h


#import <Foundation/Foundation.h>

@interface NSData (NSInputStream)

/**
 * @param capacity May be NSUIntegerMax, in which case just an ordinary [NSMutableData data] is used.  Otherwise this is given to NSMutableData dataWithCapacity:].
 * @param error May be nil.
 * @return The data or nil on failure in which case *error will be set.
 */
+(NSData*)dataWithContentsOfStream:(NSInputStream*)input initialCapacity:(NSUInteger)capacity error:(NSError **)error;

@end


#endif /* NSData_NSInputStream_h */
