// 평문을 입력받아 암호화하여 저장.
// 사용후 평문을 메모리에서 지울수 있는 함수를 제공한다.
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

#import "ProtectedData.h"

@interface SecureData : ProtectedData
//평문을 입력받아 암호화하여 저장하고 입력받은 평문은 초기화한다.
- (id)initWithData:(unsigned char*)plaintext length:(unsigned int)length;
- (id)initWithData:(SKData*)plaintext;
- (int)setData:(unsigned char*)data length:(unsigned int)length;
- (int)setData:(SKData*)data;
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
