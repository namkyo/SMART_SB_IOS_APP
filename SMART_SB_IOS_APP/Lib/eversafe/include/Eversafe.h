//
//  Eversafe.h
//  iOSPlay
//
//  Copyright © 2015 Everspin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ESSecureFileManager.h"
#import "ESSecureUserDefaults.h"
#import "EversafeThreat.h"
#import "EversafeEncryptionContext.h"

@class Eversafe;

extern NSString *EVERSAFE_RESULT_COMPLETE;
extern NSString *EVERSAFE_RESULT_EMERGENCY;
extern NSString *EVERSAFE_RESULT_TERMINATED;
extern NSString *EVERSAFE_RESULT_TIMEOUT;
extern NSString *EVERSAFE_RESULT_ERROR;

extern NSString *EVERSAFE_REQUEST_TIMEOUT;
extern NSString *EVERSAFE_ADD_TOKEN_INFO;
extern NSString *EVERSAFE_ADD_OTP_TIMESTAMP;

extern NSString *EVERSAFE_BLOCK_DEBUGGER;
extern NSString *EVERSAFE_POLICY_DEBUGGER;
extern NSString *EVERSAFE_POLICY_OS;
extern NSString *EVERSAFE_POLICY_PROXY;

extern NSString *EVERSAFE_LOCAL_LANG;
extern NSString *EVERSAFE_TOAST;

/*!
 * @desc 에버세이프 동작 중 각종 이벤트 전달에 사용될 프로토콜 정의
 */
@protocol EversafeDelegate

/*!
 * @desc 더이상 진행할 수 없는 에러가 발생함을 알림. 에버세이프의 동작은 중지된다.
 * @param error 에러 정보
 */
- (void)eversafeDidFailWithErrorCode:(NSString *)errorCode errorMessage:(NSString *)errorMessage;

/*!
 * @desc 보안 위협이 진단되었음을 알림. 에버세이프의 동작은 중지된다.
 * @param threats 진단된 보안위협에 대한 정보
 */
- (void)eversafeDidFindThreats:(NSArray *)threats;

@end


/*!
 * @desc 에버세이프 보안 모듈을 설정하고 제어할 수 있는 클래스
 */
@interface Eversafe : NSObject

+ (Eversafe *)sharedInstance;

/*!
 * @desc EversafeDelegate 를 구현한 구현체. 에버세이프 동작 중 각종 이벤트 전달에 사용된다.
 */
@property (weak) id<EversafeDelegate> delegate;

/*!
 * @desc 에버세이프 보안 모듈의 동작을 개시한다.
 * @param baseUrl 에버세이프 보안 서버 접근 주소 (예: https://eversafe.co.kr:4443/eversafe )
 * @param appId 에버세이프 보안 서버에서 해당 앱을 위해 발급된 APP_ID
 * @param userInfo 부가 설정 정보
 *             EVERSAFE_REQUEST_TIMEOUT: 보안서버와 메세지를 주고 받을 때 통신 최대 대기시간 (기본 60초)
 *             EVERSAFE_BLOCK_DEBUGGER: 디버거 접속 차단 기능을 활성화 할지 여부 (디버거 접속시 바로 앱 종료됨)
 *             EVERSAFE_POLICY_DEBUGGER: 기본모듈 동작시 디버거 탐지정책
 *             EVERSAFE_POLICY_OS: 기본모듈 동작시 OS위변조 탐지 정책
 * @note Threadsafety: YES
 */
- (void)initializeWithBaseUrl:(NSString *)baseUrl appId:(NSString *)appId userInfo:(NSDictionary *)userInfo;

/*!
 * @desc 에버세이프 보안 모듈의 동작을 개시한다. 부가설정 정보는 기본값으로 설정한다.
 * @param baseUrl 에버세이프 보안 서버 접근 주소 (예: https://eversafe.co.kr:4443/eversafe )
 * @param appId 에버세이프 보안 서버에서 해당 앱을 위해 발급된 APP_ID
 * @note Threadsafety: YES
 */
- (void)initializeWithBaseUrl:(NSString *)baseUrl appId:(NSString *)appId;


/*!
 * @desc 서버간 검증용 토큰을 받아온다.
 * @param completionBlock 완료시 호출될 블록.
 *          result: 결과상태값
 *              EVERSAFE_RESULT_COMPLETE: 토큰 수신 완료
 *              EVERSAFE_RESULT_EMERGENCY: 비상모드 토큰 수신 완료
 *              EVERSAFE_RESULT_TERMINATED: 토큰 수신 실패 (에버세이프 동작이 중단된 상태)
 *              EVERSAFE_RESULT_TIMEOUT: 토큰 수신 실패 (타임아웃 시간 도달)
 *              EVERSAFE_RESULT_ERROR: 라이브러리가 정상적으로 초기화되지 않음
 *          verificationToken: 검증토큰
 * @param timeout 최대 대기 시간 (-1 인 경우 timeout 없음)
 * @note -[start] 를 호출하여 온라인모드 진입을 요청한 이후에 호출하여야한다.
 * @note completionBlock 은 main thread 에서 호출된다.
 * @note Threadsafety: YES
 */
- (void)getVerificationToken:(void (^)(NSString *result, NSData *verificationToken ))completionBlock timeout:(NSTimeInterval)timeout;

/*!
 * @desc 서버간 검증용 토큰을 동기 방식으로 받아온다.
 * @param timeout 최대 대기 시간 (-1 이하인 경우 timeout 없음)
 * @param result 결과상태값
 *              EVERSAFE_RESULT_COMPLETE: 토큰 수신 완료
 *              EVERSAFE_RESULT_EMERGENCY: 비상모드 토큰 수신 완료
 *              EVERSAFE_RESULT_TERMINATED: 토큰 수신 실패 (에버세이프 동작이 중단된 상태)
 *              EVERSAFE_RESULT_TIMEOUT: 토큰 수신 실패 (타임아웃 시간 도달)
 *              EVERSAFE_RESULT_ERROR: 라이브러리가 정상적으로 초기화되지 않음
 * @returns 검증용 토큰
 * @note Main RunLoop 가 내부적으로 실행됨에 유의할 것. (재귀적인 호출 가능성을 없애기 위한 UI 처리가 필요함)
 * @note -[start] 를 호출하여 온라인모드 진입을 요청한 이후에 호출하여야한다.
 * @note Threadsafety: YES
 */
- (NSData *)getVerificationTokenWithTimeout:(NSTimeInterval)timeout result:(NSString **)result __attribute((deprecated("Use getVerificationToken insted.")));

/*!
 * @desc 종단간 암호화를 위한 Encryption Context 를 받아온다
 * @param completionBlock 완료시 호출될 블록.
 *          encryptionContext: 취득된 Encryption Context
 * @param timeout 최대 대기 시간 (-1 이하인 경우 timeout 없음)
 * @note completionBlock 은 main thread 에서 호출된다.
 * @note Threadsafety: YES
 */
- (void)getEncryptionContext:(void (^)(EversafeEncryptionContext *encryptionContext))completionBlock timeout:(NSTimeInterval)timeout;

/*!
 * @desc 기존에 수신한 Encryption Context 를 파기하고 새로운 Encryption Context 가 취득되도록 유도한다.
 * @note Threadsafety: YES
 */
- (void)invalidateEncryptionContext;


/*!
 * @desc secure storage의 secureInfo를 설정하기 위 한 메서드
 */
- (void)setSeucreStorageInfo:(NSString *)secureInfo;

- (ESSecureFileManager *)secureFileManager;

- (ESSecureUserDefaults *)secureUserDefaultsWithName:(NSString *)name;

@end
