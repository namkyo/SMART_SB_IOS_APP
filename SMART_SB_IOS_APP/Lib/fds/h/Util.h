//
//  FdsUtil.h
//  fdsSample
//
//  Created by 김명호_맥북 on 2019/12/19.
//  Copyright © 2019 김명호_맥북. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeychainItemWrapper.h"

NS_ASSUME_NONNULL_BEGIN

@interface Util : NSObject

+ (NSString*) getUUID : (NSString *) identifier;

@end

NS_ASSUME_NONNULL_END
