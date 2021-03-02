//
//  eversafe_keypad_ios_library-0.8.1
//  ESKeypadMagAppearanceManager.h
//
//  Copyright © Everspin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESKeyMagViewAlign.h"
#import "ESKeypadImageInfoKeys.h"

@interface ESKeypadMagAppearanceManager : NSObject

// @desc 각 문자키의 이미지를 지정할 수 있는 API
// @returns 키의 이미지가 지정된 Dictionary 객체. 키를 나타내지 않으려면 nil 을 리턴한다.

- (NSDictionary *)magForegroundInfoForCharacter:(char)character;
- (NSDictionary *)magBackground:(ESKeyMagViewAlign)alignment;

@end
