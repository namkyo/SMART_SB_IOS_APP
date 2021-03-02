//
//  eversafe_keypad_ios_library-0.8.1
//  ESKeypadAppearenceManager.h
//
//  Copyright © Everspin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESSpecialKey.h"
#import "ESKeypadImageInfoKeys.h"


// @desc 키패드 뷰에서 각 키의 이미지를 설정하기 위한 클래스
@interface ESKeypadAppearenceManager : NSObject


// @desc 키패드의 배경색을 지정할 수 있는 API
- (UIColor *)keypadBackgroundColor;

// @desc 각 문자키의 이미지를 지정할 수 있는 API
// @returns 키의 이미지가 지정된 Dictionary 객체. 키를 나타내지 않으려면 nil 을 리턴한다.
- (NSDictionary *)customImagesInfoForCharacter:(char)character;

// @desc 각 특수키의 이미지를 지정할 수 있는 API
// @returns 키의 이미지가 지정된 Dictionary 객체. 키를 나타내지 않으려면 nil 을 리턴한다.
- (NSDictionary *)customImagesInfoForSpecialKey:(ESSpecialKey)specialKey;

// @desc 빈 키의 이미지를 지정할 수 있는 API
// @returns 키의 이미지가 지정된 Dictionary 객체. 키를 나타내지 않으려면 nil 을 리턴한다.
- (NSDictionary *)customImagesInfoForNullKeys;

@end
