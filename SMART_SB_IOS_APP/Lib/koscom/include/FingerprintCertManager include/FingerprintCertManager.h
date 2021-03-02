
//  Created by kimsd of koscom on 2016.07.27
//  Copyright © 2016 Koscom All rights reserved.
//  구성
// 인증서와 비밀키는 키체인에 저장되어 있고, 일반 보안키패드를 통해 입력하는 패스워드로 암호화되어 있는 상태이다.
// 지문기능을 등록하면, 기존 인증서와 비밀키는 유지되며, 지문검증을 받는 비밀키가 하나 더 추가되는 형태이다.
// CertManager는 인증서와 일반 패스워드로 암호화된 비밀키를 관리하지만,
// FingerprintCertManager는 지문검증을 수행하는 인증서의 비밀키만 관리한다.
// 특히 CertManager로 인증서를 delete하면 인증서-비밀키-지문비밀키를 모두 지운다.
// 하지만 FingerprintCertManager는 지문검증을 수행하는 인증서의 비밀키만 키체인에서 삭제한다.

#import <Foundation/Foundation.h>
#import "CertManager.h"
#import "KSpkcs8Util.h"

@interface FingerprintCertManager : NSObject {
    BOOL mAutoSign;
    int mAutoSignInterval;
    NSTimeInterval mLastSignTime;
    BOOL mFingerprintAuthenticated;
    
    NSString *mLastErrorLog;
    int mLastErrorCode;
    
    NSString * sharingGroup;
    BOOL sharingOption;
    int mBioType;
}


@property (nonatomic, retain) SecureData *mCertPassword;

@property (nonatomic, retain) NSString * operationPrompt;
///
+ (instancetype) sharedInstance;
+ (instancetype) sharedInstanceWithSharingGroup : (NSString *) _sharingGroup;
- (instancetype) initWithSharingGroup : (NSString *) _sharingGroup;

// 지문용 인증서 비밀키가 등록된 인증서의 갯수를 반환한다.
-(int) count;

// SubjectDN을 이용하여 지문인증서의 인덱스를 가져온다.
- (int) getCertIdxBySubjectDN:(NSString *) dn;

// 키체인에 등록되어 있는 인증서에 지문기능을 추가한다.
// subjectDN는 일반 인증서 관리 클래스인 CertManager를 통해 받은 정보여야 하며
// password는 사용자가 보안키패드를 통해 입력한 인증서 비밀번호이다.
- (BOOL) addFingerprint:(NSString*)subjectDN currentPW:(ProtectedData*)currentPW isAuthentication : (BOOL) isAuthentication;

// 지문용 인증서 비밀키를 삭제한다.
- (BOOL) deleteFingerprint:(int)idx isAuthentication : (BOOL) isAuthentication;

/// 지문기능이 있는 인증서 중 인덱스의 인증서를 반환한다.
- (Certificate *)getCert:(int)idx;

- (int) getPublicKey : (int) idx publicKey : (char *) pubKey;

- (NSData *) getRandom : (int) idx;

- (int) checkCertPassword : (int) idx currentPassword:(ProtectedData *) currentPassword;

- (long) getRemainTimeOfAutoSignInterval;

/// 코스콤 전자서명(Full)
- (int) KoscomSign:(int)idx signSource:(NSData *)signSource signResult:(char *)signResult;

/// 코스콤 축약서명
- (int) KoscomBriefSign:(int)idx signSource:(NSData *)signSource signResult:(char *)signResult;

/// CMS 서명
- (int) CMSSign:(int)idx signSource:(NSData *)signSource signResult:(char *)signResult;

/// CMS 축약서명
- (int) CMSBriefSign:(int)idx signSource:(NSData *)signSource signResult:(char *)signResult;

// 자동서명 적용 여부
- (void)setAutoSign:(BOOL)value;

// 자동서명 시간 제한 설정
- (void)setAutoSignInterval:(unsigned int)second;

// 지문 연동에 문제가 되는 경우 FingerpinrCertManager가 관리하는 모든 정보를 삭제한다.(인증서와 일반 패스워드로 암호화된 비밀키만 남김)
//- (void) removeAll;

// 마지막에 발생한 에러로그를 반환합니다.
- (NSString *)getLastErrorString;

// 마지막에 발생한 에러코드를 반환합니다.
- (int) getLastErrorCode;
@end
