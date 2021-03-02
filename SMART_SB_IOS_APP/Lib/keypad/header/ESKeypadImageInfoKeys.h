//
//  eversafe_keypad_ios_library-0.8.1
//  ESKeypadImageInfoKeys.h
//
//  Copyright © Everspin. All rights reserved.
//

#import <Foundation/Foundation.h>

// 이미지 지정을 위한 Dictionary Key 이름

// @desc 키가 눌러지지 않았을 때의 배경 이미지
//       키 영역에 가득 채워서 보여진다.
extern NSString *ESKeyNormalBackgroundImage;

// @desc 키가 눌린 상태의 배경 이미지
//       키 영역에 가득 채워서 보여진다.
extern NSString *ESKeyHighlightedBackgroundImage;

// @desc 키가 눌러지지 않았을 때의 문자 이미지
//       가로 세로 비율을 보존하여 crop 되는 부분이 없이 가운데 정렬하여 보여진다.
extern NSString *ESKeyNormalSymbolImage;

// @desc 키가 눌린 상태의 문자 이미지
//       가로 세로 비율을 보존하여 crop 되는 부분이 없이 가운데 정렬하여 보여진다.
extern NSString *ESKeyHighlightedSymbolImage;



extern NSString *ESKeyMagnifierBackgroundImage;

extern NSString *ESKeyMagnifierSymbolImage;


@interface ESKeypadImageInfoKeys : NSObject

@end
