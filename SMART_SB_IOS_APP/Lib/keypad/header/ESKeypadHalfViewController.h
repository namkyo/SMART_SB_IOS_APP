//
//  eversafe_keypad_ios_library-0.8.1
//  ESKeypadHalfViewController.h
//
//  Copyright © Everspin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESKeypadSpec.h"
#import "ESKeypadViewController.h"

// @desc 보안 문자를 입력받는 View Controller.
//       화면 반 정도의 최소한의 공간을 사용하며 나머지 공간은 투명하게 상위 View Controller 가 보인다.
@interface ESKeypadHalfViewController : ESKeypadViewController

@property UIColor *controlBackgroundColor;

- (void)presentWithParentViewController:(UIViewController *)viewController;

@end
