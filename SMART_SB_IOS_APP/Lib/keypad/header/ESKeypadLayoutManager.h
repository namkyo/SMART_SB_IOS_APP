//
//  eversafe_keypad_ios_library-0.8.1
//  ESKeypadLayoutManager.h
//
//  Copyright © Everspin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESSpecialKey.h"
#import "ESGraphicTools.h"

@class ESKeypadView;

// @desc 키패드 뷰 안에서 각 키의 위치 및 배열을 설정하기 위한 클래스
@interface ESKeypadLayoutManager : NSObject

// @desc 본 KeypadLayoutManager 와 연관된 keypadView 가 설정된다.
//       KeypadLayoutManager 구현시 참고할 수 있다.
@property (weak) ESKeypadView *keypadView;

// @desc 본 키패드 뷰를 표시할 뷰의 크기에 적당한 키패드 size 를 계산한다.
- (CGSize)suggestedSizeForContainerSize:(CGSize)size;

// @desc 특정 row, column 에 해당하는 키가 위치할 좌표를 설정
- (CGRect)frameForKeyAtRow:(NSUInteger)row column:(NSUInteger)column;

// @desc 특정 특수키가 위치할 좌표를 설정
- (CGRect)frameForSpecialKey:(ESSpecialKey)specialKey;

@end
