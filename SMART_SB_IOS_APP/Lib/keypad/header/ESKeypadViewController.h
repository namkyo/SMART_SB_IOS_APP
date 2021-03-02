//
//  eversafe_keypad_ios_library-0.8.1
//  ESKeypadViewController.h
//
//  Copyright © Everspin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESKeypadSpec.h"

@class ESKeypadViewController;

// @desc 보안키패드 화면에서의 유저의 입력결과를 받는 Delgate
@protocol ESKeypadViewControllerDelegate <NSObject>

// @desc 유저가 입력완료 버튼을 눌러 입력을 완료했을 때 불릴 이벤트
- (void)keypadViewControllerDidEndInput:(ESKeypadViewController *)keypadViewController;

// @desc 유저가 취소 버튼을 눌렀을 때 불릴 이벤트
- (void)keypadViewControllerDidCancelInput:(ESKeypadViewController *)keypadViewController;

@optional

// @desc 유저가 입력완료 버튼을 눌렀을 때 입력을 실제로 완료할 것인지를 리턴한다.
// @returns 입력완료 처리를 하지 않으려면 NO, 완료하려면 YES
- (BOOL)keypadViewControllerShouldEndInput:(ESKeypadViewController *)keypadViewController;

@end

// @desc 보안 문자를 입력받는 View Controller
@interface ESKeypadViewController : UIViewController

// @desc 사용자 이벤트 수신 및 세부 제어를 위한 Delgate
@property (weak) id<ESKeypadViewControllerDelegate> delegate;


//////////////////////////////
// Factory Methods
//////////////////////////////

// @desc 보안키패드 View Controller 를 생성한다.
// @param spec 사용할 키패드에 대한 세부사항이 설정된 Spec 인스턴스
+ (instancetype)newKeypadWithSpec:(ESKeypadSpec *)spec;


//////////////////////////////
// Settings Methods
//////////////////////////////

// @desc 상단 타이틀바에 표시될 문구 설정
// @note view controller 가 로드되기 전에 설정하여야한다.
@property (strong) NSString *mainTitle;

// @desc 상단 내용자리에 표시될 문구 설정
// @note view controller 가 로드되기 전에 설정하여야한다.
@property (strong) NSString *subTitle;

// @desc 텍스트필드에 표시될 문구 설정
// @note view controller 가 로드되기 전에 설정하여야한다.
@property (strong) NSString *placeholderText;

//////////////////////////////
// Data Methods
//////////////////////////////

// @desc 암호화된 입력데이터를 얻는다.
- (NSData *)encryptedData;

// @desc 암호화된 입력데이터를 얻는다. (BASE64 인코딩된)
- (NSString *)encryptedString;

// @desc 외부 연동을 위한 암호화된 입력데이터를 얻는다. (SEED 암호화 모드에서만 가능)
- (NSData *)encryptedDataForThirdParty;

// @desc 외부 연동을 위한 암호화된 입력데이터를 얻는다. (BASE64 인코딩된) (SEED 암호화 모드에서만 가능)
- (NSString *)encryptedStringForThirdParty;

// @desc 입력된 문자의 길이를 구한다.
- (NSUInteger)enteredCharacters;

// @desc 평문을 얻는다.
//       얻은 평문은 사용 후 즉시 putPlainText 로 반환하도록 한다.
// @note RSA 암호화 모드에서는 얻을 수 없다.
- (char *)getPlainText;

// @desc 평문을 반환한다.
// @param plainText getPlainText 를 이용하여 얻은 평문
- (void)putPlainText:(char *)plainText;

@end
