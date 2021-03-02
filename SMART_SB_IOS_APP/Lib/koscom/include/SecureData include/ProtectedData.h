//
//  ProtectedData.h
//  SecureData
//
//  Created by shield on 2017. 7. 17..
//  Copyright © 2017년 sungduk kim. All rights reserved.
//

#ifndef ProtectedData_h
#define ProtectedData_h

typedef struct _SKData {
    unsigned char *value;
    unsigned int length;
} SKData;

@interface ProtectedData : NSObject
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

#endif /* ProtectedData_h */
