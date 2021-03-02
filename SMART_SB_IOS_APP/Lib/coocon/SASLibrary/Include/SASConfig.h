//
//  SASConfig.h
//  SASLibrary
//
//  Created by ryujaeuk on 2020/02/10.
//  Copyright © 2020 류재욱. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SASConfig : NSObject
+(SASConfig *)sharedInstance;
-(void)enter;
-(void)leave;

-(void)setMaxThreadCount:(int)MaxCount;

//-(dispatch_group_t)getDispatchGroup;
//-(dispatch_queue_t)getDispatchQueue;

- (void)lock;
- (void)unlock;

@end

NS_ASSUME_NONNULL_END
