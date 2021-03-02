//
//  eversafe_keypad_ios_library-0.8.1
//  ESKeypadView.h
//
//  Copyright © Everspin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESKeypadSpec.h"
#import "ESKeypadAppearenceManager.h"
#import "ESKeypadLayoutManager.h"
#import "ESKeypadMagAppearanceManager.h"

@interface ESKeypadView : UIView

@property (strong) ESKeypadSpec *keypadSpec;
@property (nonatomic, assign, readonly) ESKeypadAppearenceManager *appearenceManager;
@property (nonatomic, assign, readonly) ESKeypadLayoutManager *layoutManager;
@property (nonatomic, assign, readonly) ESKeypadMagAppearanceManager *magAppearanceManager;

- (instancetype)initWithFrame:(CGRect)frame
                   keypadSpec:(ESKeypadSpec *)keypadSpec;

@end
