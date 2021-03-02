//
//  SafetokenPatternAuthError.h
//  SafetokenPattern
//
//  Created by KimMinSu on 10/04/2019.
//  Copyright © 2019 8BYTE. All rights reserved.
//

#ifndef SafetokenPatternAuthError_h
#define SafetokenPatternAuthError_h

#define SAFETOKEN_PATTERN_ERROR_DOMAIN   @"SafetokenPatternAuth"

#define ERROR_STORE_PATTERN_CREDENTIAL      -10000  // 패턴 인증 정보 저장 실패
#define ERROR_ENCRYPT_PATTERN_CREDENTIAL    -10001  // 패턴 인증 정보 암호화 실패
#define ERROR_NOT_EXIST_PATTERN_CREDENTIAL  -10002  // 저장된 패턴 인증 정보 없음
#define ERROR_PATTERN_AUTHENTICATION        -10003  // 패턴 인증 실패
#define ERROR_PATTERN_GENERATE_SIGN         -10004  // 전자서명 생성 실패
#define ERROR_LOAD_PATTERN_CREDENTIAL       -10005  // 패턴 인증 정보 불러오기 실패
#define ERROR_REMOVE_PATTERN_CREDENTIAL     -10006  // 패턴 인증 정보 삭제 실패

#endif /* SafetokenPatternAuthError_h */
