//
//  Copyright © 2020 Everspin. All rights reserved.
//

#ifndef ESSecureFileManager_h
#define ESSecureFileManager_h

#import <Foundation/Foundation.h>

@interface ESSecureFileManager : NSObject

- (nullable NSData *)contentsAtPath:(nonnull NSString *) path;

- (BOOL) createFileAtPath:(nonnull NSString *) path
                 contents:(nonnull NSData *) content
               attributes:(nullable NSDictionary<NSFileAttributeKey,id> *)attribute;
@end

#endif
