//
//  eversafe_keypad_ios_library-0.8.1
//  ESGraphicTools.h
//
//  Copyright © Everspin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ESGraphicTools : NSObject

+ (UIImage *)resizeableImageWithColor:(UIColor *)color ;
+ (UIColor *)colorWithARGBInt:(NSInteger) argb;
+ (UIImage *)resizableImageWithColorARGB:(NSInteger) argb;

@end
