//
//  NSHCData.h
//  SecureData
//
//  Created by shield on 2017. 7. 17..
//  Copyright © 2017년 sungduk kim. All rights reserved.
//

#ifndef NSHCData_h
#define NSHCData_h

// 암호문을 입력받아 사용할 때 복호화하여 사용한다.
// NSHC에서 제공받은 FilterPubKey를 입력하여 내부적으로 복호화할 수 있게한다.
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

#import "ProtectedData.h"
#include "Util.h"

@interface NSHCData : ProtectedData
//암호문과 FilterPubKey를 입력하여 NSHCData를 생성한다.
- (id)initWithData:(NSString*)pubKey data:(NSString*)data;
- (id)initWithData:(unsigned char*)pubKey length:(unsigned int)pubKeyLength
              data:(unsigned char*)data length:(unsigned int)dataLength;
- (void)setEncryptedData:(NSString*)data;
- (void)setEncryptedData:(unsigned char*)data length:(unsigned int)dataLength;
- (void)setNFilterPubKeyData:(NSString*)pubKey;
- (void)setNFilterPubKeyData:(unsigned char*)pubKey length:(unsigned int)pubKeyLength;
//암호화되어있는 값을 복호화하여 평문을 리턴한다.
//getData수행후에는 clearData를 필히 수행하여 메모리에 남지 않도록 한다.
- (SKData *)getData;
//평문 및 평문 암호화에 쓰인 파라미터를 모두 초기화한다.
- (void)clearAll;
//메모리에 남아있는 평문을 삭제한다.
- (void)clearPlain;
//버전정보를 가져온다.
- (NSString*)getVersion;
@end

#endif /* NSHCData_h */
