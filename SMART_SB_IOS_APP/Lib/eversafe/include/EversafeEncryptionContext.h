//
//  EversafeEncryptionContext.h
//  iOSPlay
//
//  Copyright © 2018년 Everspin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EversafeEncryptionContext : NSObject

/*!
 * @desc 임의의 데이터를 암호화한다.
 * @param data 암호화 할 데이터
 * @returns 암호화 된 데이터
 */
- (NSData *)encryptData:(NSData *)data;

/*!
 * @desc 임의의 텍스트를 암호화한다.
 * @param text 암호화 할 텍스트
 * @returns 암호화 된 데이터
 */
- (NSData *)encryptText:(NSString *)text;

/*!
 * @desc 암호화된 데이터를 복호화한다.
 * @param data 복호화 할 데이터
 * @returns 복호화 된 데이터
 */
- (NSData *)decryptAsData:(NSData *)data;

/*!
 * @desc 암호화된 데이터를 텍스트 형태로 복호화한다.
 * @param data 복호화 할 데이터
 * @returns 복호화 된 텍스트
 */
- (NSString *)decryptAsText:(NSData *)data;

/*!
 * @desc 앱서버에 현재 Encryption Context 와 동일한 암호화키 관련 정보를 동기화하기 위해 필요한 데이터를 얻는다.
 * @returns 암호화 기술자 데이터
 */
- (NSData *)encryptionDescriptor;

/*!
 * @desc Encryption Context 취득시 함께 취득된 검증 토큰을 얻는다.
 * @returns 검증토큰 데이터
 */
- (NSData *)verificationToken;

@end
