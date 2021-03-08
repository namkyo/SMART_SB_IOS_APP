//
//  EversafeModule.h
//  EversafeModule
//
//  Created by godseop on 09/07/2018.
//  Copyright © 2018 Everspin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EversafeSessionToken;
//! Project version number for EversafeModule.
FOUNDATION_EXPORT double EversafeModuleVersionNumber;

//! Project version string for EversafeModule.
FOUNDATION_EXPORT const unsigned char EversafeModuleVersionString[];
typedef enum {
    EversafeStateStandby = 0,
    EversafeStateAuthWaiting,
    EversafeStateSessionSubmitWaiting,
    EversafeStateRetryWaiting,
    EversafeStateNormalLoop,
    EversafeStateBasicLoop,
    EversafeStateTerminated,
} EversafeState;

typedef enum {
    EversafeModeNone = 0,
    EversafeModeNormal,
    EversafeModeBasic
} EversafeMode;

@protocol EversafeCoreDelegate <NSObject>
- (void)eversafeCoreDidFailWithError:(NSError *)error;
- (void)eversafeCoreChangeState:(EversafeState)state;
- (void)eversafeCoreDidFindThreats:(NSArray *)threats;
- (void)eversafeCoreDidUpdatedWithSessionId:(NSString *)sessionId sessionToken:(EversafeSessionToken *)sessionToken;
@end


@interface XAXE71VW3H5 : NSObject
@property (weak) id<EversafeCoreDelegate> coreDelegate;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end


#define SEQ_ADDITION_1(seq) seq += -2924

#define SEQ_ADDITION_2(seq)

#define SEQ_ADDITION_3(seq)

#define SEQ_ADDITION_4(seq) seq += -551

#define SEQ_ADDITION_5(seq) seq += 225

#define SEQ_ADDITION_6(seq)

#define SEQ_ADDITION_7(seq)

#define SEQ_ADDITION_8(seq) seq += -643

#define SEQ_ADDITION_9(seq)

#define SEQ_ADDITION_10(seq)
