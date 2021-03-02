//
//  eversafe_keypad_ios_library-0.8.1
//  ESKeypadSpec.h
//
//  Copyright © Everspin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESKeypadAppearenceManager.h"
#import "ESKeypadLayoutManager.h"
#import "ESKeypadMagAppearanceManager.h"
#import "ESKeypadBtnAppearanceManager.h"

// @desc 키패드 종류 (쿼티, 숫자)
typedef enum {
    ESKeypadTypeQwerty,
    ESKeypadTypeNumber,
    ESKeypadTypeNumberLine,
    ESKeypadTypeNumericpad
} ESKeypadType ;

typedef enum {
    e_ESKeypadEncryptMethodDefault = 0,
    e_ESKeypadEncryptMethodSeed,
    e_ESKeypadEncryptMethodRSA
} ESKeypadEncryptMethod ;

// @desc 사용될 키패드에 대한 세부사항을 설정할 수 있는 클래스
@interface ESKeypadSpec : NSObject


- (instancetype)init;

// @desc 입력값을 암호화하는 알고리즘과 키를 설정한다.
// @param encryptMethod 암호화 방법을 설정한다.
// @param keyValue 암호화 방법에 따른 키를 설정한다.
//                 Default 암호화의 경우 이 값은 무시된다.
//                 SEED 암호화의 경우 16byte 의 키 값을 base64 인코딩된 형태로 지정한다.
//                 RSA 암호화의 경우 public key 를 PEM 형태로 지정한다.
- (void) setEncryptMethod:(ESKeypadEncryptMethod) encryptMethod
                  withKey:(NSString *)keyValue;

// @desc 최대 입력글자수를 설정한다. (기본값: 16, 최대값: 128)
@property (assign) NSUInteger maxInputLength;

// @desc 키패드 종류를 설정한다.
@property (assign) ESKeypadType keypadType;

// @desc 마지막 글자가 Text Field 에 표시될 시간을 설정한다.
@property (assign) NSTimeInterval lastCharDisplayTime;

// @desc 키패드 디자인을 담당하는 AppearenceManager 를 세팅한다.
// @note 기본값은 nil 이며, 기본 AppearenceManager 를 사용하겠다는 의미이다.
//       설정하는 키패드에 따라서 기본 AppearenceManager 의 클래스는
//         ESDefaultQwertyKeypadAppearenceManager,
//         ESDefaultNumericKeypadAppearenceManager
//       로 정의된다. 기본 키패드 설정에서 일부 항목만 변경하고자 하는 경우 해당하는 클래스를 Subclass 하면 된다.
@property (strong) ESKeypadAppearenceManager *appearenceManager;

// @desc 키패드 내의 모든 키의 위치 선정을 담당하는 LayoutManager 를 세팅한다.
// @note 기본값은 nil 이며, 기본 LayoutManager 를 사용하겠다는 의미이다.
//       설정하는 키패드에 따라서 기본 LayoutManager 의 클래스는
//         ESDefaultQwertyKeypadLayoutManager,
//         ESDefaultNumericKeypadLayoutManager
//       로 정의된다. 기본 키패드 설정에서 일부 항목만 변경하고자 하는 경우 해당하는 클래스를 Subclass 하면 된다.
@property (strong) ESKeypadLayoutManager *layoutManager;

// @desc 확대키의 디자인을 담당하는 MagAppearenceManager 를 세팅한다.
// @note 기본값은 nil 이며, 기본 MagAppearenceManager 를 사용하겠다는 의미이다.
//       설정하는 키패드에 따라서 기본 AppearenceManager 의 클래스는
//         ESDefaultQwertyKeypadMagAppearenceManager,
//         ESDefaultNumericKeypadMagAppearenceManager
//       로 정의된다. 기본 키패드 설정에서 일부 항목만 변경하고자 하는 경우 해당하는 클래스를 Subclass 하면 된다.
@property (strong) ESKeypadBtnAppearanceManager *btnAppearanceManager;

// @desc 확대키의 디자인을 담당하는 MagAppearenceManager 를 세팅한다.
// @note 기본값은 nil 이며, 기본 MagAppearenceManager 를 사용하겠다는 의미이다.
//       설정하는 키패드에 따라서 기본 AppearenceManager 의 클래스는
//         ESDefaultQwertyKeypadMagAppearenceManager,
//         ESDefaultNumericKeypadMagAppearenceManager
//       로 정의된다. 기본 키패드 설정에서 일부 항목만 변경하고자 하는 경우 해당하는 클래스를 Subclass 하면 된다.
@property (strong) ESKeypadMagAppearanceManager *magAppearanceManager;

// @desc 확대키를 표시할 여부를 설정한다.
@property (assign) BOOL magnifierViewEnabled;

// @desc 키 입력 효과음 재생 여부를 설정한다.
@property (assign) BOOL keyClickSound;

// @desc 키 입력 효과음로 사용할 음원의 경로를 설정한다.
//       설정되지 않은 경우 기본 음원을 사용한다.
@property (strong) NSString *keyClickSoundPath;

@end
