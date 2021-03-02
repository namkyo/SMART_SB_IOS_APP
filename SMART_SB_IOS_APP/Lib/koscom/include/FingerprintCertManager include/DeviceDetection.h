//
//  DeviceDetection.h
//  FingerprintCertManager
//
//  Created by shield on 2017. 12. 1..
//  Copyright © 2017년 koscom. All rights reserved.
//

#ifndef DeviceDetection_h
#define DeviceDetection_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <sys/utsname.h>

@interface DeviceDetection : NSObject

enum {
    MODEL_UNKNOWN=0,        /**< unknown model */
    MODEL_IPHONE_SIMULATOR, /**< iphone simulator */
    MODEL_IPAD_SIMULATOR,   /**< ipad simulator */
    MODEL_IPOD_TOUCH_GEN1,  /**< ipod touch 1st Gen */
    MODEL_IPOD_TOUCH_GEN2,  /**< ipod touch 2nd Gen */
    MODEL_IPOD_TOUCH_GEN3,  /**< ipod touch 3th Gen */
    MODEL_IPHONE,           /**< iphone  */
    MODEL_IPHONE_3G,        /**< iphone 3G */
    MODEL_IPHONE_3GS,       /**< iphone 3GS */
    MODEL_IPHONE_4,         /**< iphone 4 */
    MODEL_IPHONE_4S,        /**< iphone 4s  */
    MODEL_IPHONE_5,         /**< iphone 5 */
    MODEL_IPAD,             /**< ipad  */
    MODEL_IPAD2,            /**< ipad2  */
    MODEL_IPAD3,            /**< ipad3  */
    MODEL_IPAD4,            /**< ipad4  */
    MODEL_IPAD_MINI,        /**< ipad mini  */
    MODEL_IPHONE_X          /**< iphone X */
};

/**
 get the id of the detected device
 */
+ (uint) detectDevice;
/**
 get the string for the detected device
 */
+ (NSString *) returnDeviceName:(BOOL)ignoreSimulator;

@end
#endif /* DeviceDetection_h */
