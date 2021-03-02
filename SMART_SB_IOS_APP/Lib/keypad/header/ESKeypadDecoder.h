//
//  eversafe_keypad_ios_library-0.8.1
//  ESKeypadDecoder.h
//
//  Copyright © Everspin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESKeypadSpec.h"

// @desc 키패드 입력값을 복호화하기 위한 클래스
@interface ESKeypadDecoder : NSObject

// @desc 암호화값을 복호화하기 위한 알고리즘과 키를 설정한다.
// @param encryptMethod 암호화 방법을 설정한다.
// @param keyValue 암호화 방법에 따른 키를 설정한다.
//                 Default 암호화의 경우 이 값은 무시된다.
//                 SEED 암호화의 경우 16byte 의 키 값을 base64 인코딩된 형태로 지정한다.
//                 RSA 암호화는 클라이언트측에서는 복호화할 수 없다. 서버 라이브러리를 통해서만 복호화가 가능하다.
- (void) setEncryptMethod:(ESKeypadEncryptMethod) encryptMethod
                  withKey:(NSString *)keyValue;

// @desc 평문을 얻는다.
//       얻은 평문은 사용 후 즉시 putPlainText 로 반환하도록 한다.
// @param encryptedData 암호화된 입력값
- (char *)getPlainTextForEncryptedData:(NSData *)encryptedData;

// @desc 평문을 얻는다.
//       얻은 평문은 사용 후 즉시 putPlainText 로 반환하도록 한다.
// @param encryptedString 암호화된 입력값
- (char *)getPlainTextForEncryptedString:(NSString *)encryptedString;

// @desc 평문을 반환한다.
// @param plainText getPlainTextForEncryptedData 를 이용하여 얻은 평문
- (void)putPlainText:(char *)plainText;

@end
