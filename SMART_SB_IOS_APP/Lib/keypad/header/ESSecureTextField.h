//
//  eversafe_keypad_ios_library-0.8.1
//  ESSecureTextField.h
//
//  Copyright © Everspin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESKeypadView.h"
#import "ESKeypadSpec.h"

@class ESSecureTextField;

@protocol ESSecureTextFieldDelegate <NSObject>
@optional
- (BOOL)secureTextFieldShouldBeginEditing:(ESSecureTextField *)secureTextField;        // return NO to disallow editing.
- (void)secureTextFieldDidBeginEditing:(ESSecureTextField *)secureTextField;           // became first responder
- (BOOL)secureTextFieldShouldEndEditing:(ESSecureTextField *)secureTextField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)secureTextFieldDidEndEditing:(ESSecureTextField *)secureTextField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)secureTextFieldShouldClear:(ESSecureTextField *)secureTextField;               // called when clear button pressed. return NO to ignore (no notifications)
- (void)secureTextFieldDidReturn:(ESSecureTextField *)secureTextField;              // called when 'return' key pressed. return NO to ignore.
- (void)secureTextFieldDidCancel:(ESSecureTextField *)secureTextField;
- (void)secureTextFieldDidChangeText:(ESSecureTextField *)secureTextField;
@end


// @desc 보안키패드와 함께 동작하는 TextField
//       Xib 를 통한 초기화는 불가능하며 코드로 초기화하여야만 한다.
//       연결되어 있는 키패드 뷰가 제공되며 뷰를 화면에 나타내고 위치시키는 역할은
//       본 클래스의 유저가 구현하여야함.
IB_DESIGNABLE
@interface ESSecureTextField : UITextField

@property (weak, nonatomic) IBInspectable NSString* inputType;
@property (weak, nonatomic) IBInspectable NSString* encryptMethod;
@property (weak, nonatomic) IBInspectable NSString* encryptKeyValue;
@property (assign, nonatomic) IBInspectable CGFloat textSize;
@property (assign, nonatomic) IBInspectable NSUInteger maxLength;

- (instancetype)initWithFrame:(CGRect)frame spec:(ESKeypadSpec *)spec;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

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

// @desc 입력값을 모두 삭제한다.
- (void)clear;


@property (weak) id<ESSecureTextFieldDelegate> secureTextFieldDelegate;

// @desc 이 TextField 와 연결된 보안키패드 뷰
- (ESKeypadView *)keypadView;

@end
