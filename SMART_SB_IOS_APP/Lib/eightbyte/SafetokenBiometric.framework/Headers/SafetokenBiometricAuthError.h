//
//  SafetokenBiometricAuthError.h
//  SafetokenBiometric
//
//  Created by KimMinSu on 11/04/2019.
//  Copyright © 2019 8BYTE. All rights reserved.
//

#ifndef SafetokenBiometricAuthError_h
#define SafetokenBiometricAuthError_h

#define ERROR_STORE_BIOMETRIC_CREDENTIAL        -10000  // 인증 정보 저장 실패
#define ERROR_ENCRYPT_BIOMETRIC_CREDENTIAL      -10001  // 인증 정보 암호화 실패
#define ERROR_NOT_EXIST_BIOMETRIC_CREDENTIAL    -10002  // 저장된 인증 정보 없음
#define ERROR_BIOMETRIC_AUTHENTICATION          -10003  // 인증 실패
#define ERROR_BIOMETRIC_GENERATE_SIGN           -10004  // 전자서명 생성 실패
#define ERROR_LOAD_BIOMETRIC_CREDENTIAL         -10005  // 인증 정보 불러오기 실패
#define ERROR_REMOVE_BIOMETRIC_CREDENTIAL       -10006  // 인증 정보 삭제 실패

#define ERROR_BIOMETRIC_NOT_AVAILABLE           -20001  // 생체인증 지원하지 않음
#define ERROR_BIOMETRIC_LOCKOUT                 -20002  // 생체인증 시도횟수가 많아 시스템에 의해 사용이 중지된 상태
#define ERROR_PASSCODE_NOT_SET                  -20003  // 단말 비밀번호가 설정되어 있지 않음
#define ERROR_BIOMETRIC_NOT_ENROLLED            -20004  // 생체인증이 등록되어 있지 않음
#define ERROR_NOT_EXIST_BIOMETRIC_KEYCHAIN      -20005  // 생체인증과 연동된 키체인 아이템이 존재하지 않음
#define ERROR_BIOMETRIC_USER_CANCEL             -20006  // 사용자가 생체인증을 취소함
#define ERROR_BIOMETRIC_SYSTEM_CANCEL           -20007  // 시스템이 생체인증을 취소함
#define ERROR_INVALID_BIOMETRIC_KEYCHAIN        -20008  // 키체인 아이템의 정보가 올바르지 않음. (발생할 수 없음)
#define ERROR_BIOMETRIC_NOT_AVAILABLE_TEMPORARY -20009  // 생체인증을 사용할 수 없는 상태

#endif /* SafetokenBiometricAuthError_h */
