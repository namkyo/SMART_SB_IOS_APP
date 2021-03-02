//
//  CertManager.h
//

#import <Foundation/Foundation.h>
#import "Certificate.h"
#import "KeyChainManager.h"
#import "KScmp.h"
#import "KSutil.h"
#import "ProtectedData.h"
#import "SecureData.h"

@class FMDatabase;
@interface CertManager : NSObject {
    NSMutableArray* arrCert;
    int currIndex;
    FMDatabase *dbase;
    KSKeyChainManager* keyChainManager;
    NSData* lastCopiedCert;
    
    NSString* label;//for saving key with secure data
    
    
}


@property (nonatomic, retain) NSMutableArray* arrCert;
@property (nonatomic, retain) KSKeyChainManager* keyChainManager;
@property (nonatomic, retain) NSData* lastCopiedCert;
@property (nonatomic, retain) NSData *serverCert;
@property (nonatomic, retain) NSString *sid;
@property (nonatomic, assign) int lastErrCode;
@property (nonatomic, retain) NSString *lastErrMsg;


@property (nonatomic, assign) BOOL useIPv6;

+ (NSString *) getLibraryVersion; //라이브러리 버전 정보

//[2013.06.11] add
- (id)initWithSofo;

- (id)initWithSharingGroup:(NSString*)sharingGroup;
- (id)initWithSofoSharingGroup:(NSString*)sharingGroup;
- (id)initWithSharingGroupAndLabel:(NSString *) sharingGroup label : (NSString *) aLabel;
- (int) count; //arrCert에 저장되어 있는 인증서 갯수 반환

//manage labeled key
- (id) initWithLabel:(NSString*)label;

- (void) instanceRefresh;

- (void)reloadFromKeychain:(NSString*)_label;

//set Billing Flag
- (void) setBillFlag : (BOOL) flag;
//auth

//인증서암호변경
- (BOOL) changeCertPassword:(int)idx oldPassword:(NSString *)oldPassword newPassword:(NSString *) newPassword;
//인증서암호확인
- (int) checkCertPassword:(int)idx currentPassword:(NSString *)currentPassword;
//인증서본인확인
- (int) selfUserVerify: (int)idx idv:(NSString *)idv password:(NSString *)password;
//인증서삭제
- (BOOL) delCert:(int)idx;
//인증서복사
- (int) copyCertFromPC1_Pod: (char*)cnum SN:(NSString*)SN firstAddr:(char*)addr1 secondAddr:(char*)addr2 port:(int)port;
- (int) copyCertFromPC2_Pod:(int) sock SN:(NSString*) SN;
//전자서명
- (int) cmsSign:(int)idx password:(NSString*)password signSource:(NSData*)signSource signResult:(char*)signResult;
- (int) cmsSignHash:(int)idx password:(NSString*)password hashedSignSource:(NSData*)hashedSignSource dummy:(NSData*)dummy signResult:(char*)signResult;
//증권전산 전자서명 (ver1.1.8 subjectDN 뽑아오도록 변경)
- (int) koscomSign:(int)idx password:(NSString*)password signSource:(NSData*)signSource signResult:(char*)signResult;
//축약서명 (xc241에서 검증)
- (int) simpleSign:(int)idx password:(NSString*)password signSource:(NSData*)signSource signResult:(char*)signResult;
- (int) simpleSignHash:(int)idx password:(NSString*)password hashedSignSource:(NSData*)hashedSignSource signResult:(char*)signResult;
//증권전산 축약서명 (ver1.1.8 추가 - 증권전산에서 검증)
- (int) koscomSimpleSign:(int)idx password:(NSString*)password signSource:(NSData*)signSource signResult:(char*)signResult;
//외부 인증서 저장
- (BOOL) saveCertToKeyChain:(NSData*)certData key:(NSData*)keyData;
//증권전산 hash 전자서명
- (int) koscomSignHash:(int)idx password:(NSString*)password hashedSignSource:(NSData*)hashedSignSource dummy:(NSData*)dummy signResult:(char*)signResult;
//증권전산 hash 축약서명
- (int) koscomSimpleSignHash:(int)idx password:(NSString*)password hashedSignSource:(NSData*)hashedSignSource signResult:(char*)signResult;

//added ver3.0.12
- (BOOL) havingKmCert: (int)idx;
- (NSData*) getKmCert: (int)idx;
- (NSData*) getKmKey: (int)idx;

- (Certificate*)getCert:(int)idx; //저장된 인증서를 Certificate 객체 형태로 반환
- (NSData*) getCertificate: (int)idx; //ver2.0.2 (저장된 인증서를 NSData 객체 형태로 반환)
- (int) getPublicKey:(int)idx publicKey:(char*)publicKey; //ver1.1.5 (공개키 반환 API 추가)
- (int) getCertIdxBySubjectDN:(NSString*) dn; //ver1.1.8 (dn에 해당하는 idx 리턴 API 추가)
- (NSData*) getRandomFromKey: (int)idx password:(NSString *)password; //key파일에서 random 값 추출
- (NSData*) getVidFromCert: (int)idx; //인증서 파일에서 vid 값 추출
- (NSString*) getCertAndKeyXML: (int)idx; //xml형태로 인증서와 키를 추출
- (int) envelopIDN_R:(int)idx password:(NSString*)password idn:(NSString*)idn serverCert:(NSData*)aServerCert result:(char*)result; //주민번호 + Random 값을 envelop(deprecated)
- (int) xwVid:(int)idx password:(NSString*)password idn:(NSString*)idn serverCert:(NSData*)aServerCert result:(char*)result; //envelopIDN_R와 동일. XecureWeb 연동용

- (int) getVidHashContents: (int)idx idv:(NSString*)idv password:(NSString*)password result:(char*)result; // vid hash 직전 데이터 만드는 함수

//caName: yessign OR koscom
//testFlag: 0-> real 1-> test
- (Certificate *) issueWithRefNum:(NSString*)refNum authCode:(NSString*)authCode password:(NSString*)password caName:(NSString*)caName testFlag:(NSUInteger)testFlag;
- (int) update:(int)idx password:(NSString *) password caName:(NSString*)caName testFlag:(NSUInteger)testFlag;

// add interface matched to android.
// reIssue: true->reIssue, false->issue
// caNum : CMP_CA_YESSIGN, CMP_CA_SIGNKOREA, CMP_CA_SIGNGATE, CMP_CA_CROSSCERT
- (Certificate *) issueWithRefNum:(NSString*)refNum authCode:(NSString*)authCode ip:(NSString *)ip port:(int)port password:(NSString*)password caNum:(int)caNum isReIssue:(BOOL)isReIssue;
- (int) update:(int)idx password:(NSString *)password ip:(NSString *)ip port:(int)port caNum:(int)caNum;

- (NSString *)issueGetLastError;

- (int) revoke:(int)idx password:(ProtectedData *)password caName:(NSString*)caName testFlag:(NSUInteger)testFlag;
- (int) revoke:(int)idx password:(ProtectedData *)password ip:(NSString *)ip port:(int)port caNum:(int)caNum;

+ (BOOL)isFirstRun; //check first run after installed
+ (NSString *)UDID; //get udid

-(void)reloadFromKeychain;


// 130528 : filtering arrCert with given filter
- (void)filterCertListWithIssuer:(NSArray *)issuers;
- (void)filterCertListWithIssuerCN:(NSArray *)issuers;
- (void)filterCertListWithPolicyOid:(NSArray *)policies;
- (void)filterExpiredCert;

- (int)chainVerify:(NSData *)aCert caCert:(NSData *)aCACert;

// 140630 : enhanced password check
// 매뉴얼 참고

+ (int)checkPasswordValidity:(char *)password length:(int)len;
+ (int)checkPasswordValidityEx:(char *)password length:(int)len;
+ (int)checkPasswordValidity:(NSString *)password error:(NSError**)error;
+ (int)checkPasswordValidityEx:(NSString *)password error:(NSError**)error;

- (int)checkPasswordValidity:(char *)password length:(int)len;
- (int)checkPasswordValidityEx:(char *)password length:(int)len;


//서명(include timestamp)
- (int) cmsSign:(int)idx password:(NSString*)password signSource:(NSData*)signSource signingTime:(NSData*)signingTime signResult:(char*)signResult;
//파일전자서명
- (int) cmsSignFile:(int)idx password:(NSString*)password fileInfo:(NSData*)fileInfo fileHash:(NSData*)fileHash signingTime:(NSData*)signingTime signResult:(char*)signResult;

- (int) updateWithChangeCertPassword:(int)idx oldPassword:(NSString *) oldPassword newPassword:(NSString *) newPassword caName:(NSString *) caName testFlag:(NSUInteger)testFlag;
@end

@interface CertManager(TransKey)
- (int)xwVid_T:(int)idx password:(NSString*)password randomKey:(NSData*)randomKey idn:(NSString*)idn serverCert:(NSData*)aServerCert result:(char*)result;
- (int) envelopIDN_R_T:(int)idx password:(NSString*)password randomKey:(NSData*)randomKey idn:(NSString*)idn serverCert:(NSData*)aServerCert result:(char*)result;
- (NSData*) getRandomFromKey_T: (int)idx password:(NSString *)password randomKey:(NSData*)_randomKey;
- (int) cmsSign_T:(int)idx password:(NSString*)password randomKey:(NSData*)randomKey signSource:(NSData*)signSource signResult:(char*)signResult;
- (int) cmsSignHash_T:(int)idx password:(NSString*)password hashedSignSource:(NSData*)hashedSignSource dummy:(NSData*)dummy signResult:(char*)signResult;
- (int) cmsSign_T:(int)idx password:(NSString*)password randomKey:(NSData*)randomKey signSource:(NSData*)signSource signingTime:(NSData*)signingTime signResult:(char*)signResult;
- (int) cmsSignFile_T:(int)idx password:(NSString*)password randomKey:(NSData*)randomKey fileInfo:(NSData*)fileInfo fileHash:(NSData*)fileHash signingTime:(NSData*)signingTime signResult:(char*)signResult;
- (int) koscomSign_T:(int)idx password:(NSString*)password randomKey:(NSData*)randomKey signSource:(NSData*)signSource signResult:(char*)signResult;
- (int) koscomSignHash_T:(int)idx password:(NSString*)password randomKey:(NSData*)randomKey hashedSignSource:(NSData*)hashedSignSource dummy:(NSData*)dummy signResult:(char*)signResult;
- (int) simpleSign_T:(int)idx password:(NSString*)password randomKey:(NSData*)randomKey signSource:(NSData*)signSource signResult:(char*)signResult;
- (int) simpleSignHash_T:(int)idx password:(NSString*)password randomKey:(NSData*)randomKey hashedSignSource:(NSData*)hashedSignSource signResult:(char*)signResult;
- (int) koscomSimpleSign_T:(int)idx password:(NSString*)password randomKey:(NSData*)randomKey signSource:(NSData*)signSource signResult:(char*)signResult;
- (int) koscomSimpleSignHash_T:(int)idx password:(NSString*)password randomKey:(NSData*)randomKey hashedSignSource:(NSData*)hashedSignSource signResult:(char*)signResult;
- (BOOL) changeCertPassword_T:(int)idx oldPassword:(NSString *)oldPassword oldRandomKey:(NSData *)oldRandomKey newPassword:(NSString *)newPassword newRandomKey:(NSData *)newRandomKey;
- (BOOL) changeCertPassword_T_checkValidity:(int)idx oldPassword:(NSString *)oldPassword oldRandomKey:(NSData *)oldRandomKey newPassword:(NSString *)newPassword newRandomKey:(NSData *)newRandomKey;
- (int) checkCertPassword_T:(int)idx currentPassword:(NSString *)currentPassword randomKey:(NSData *)randomKey;
- (int) getVidHashContents_T: (int)idx idv:(NSString*)idv password:(NSString *)password randomKey:(NSData *)randomKey result:(char*)result;
- (int) selfUserVerify_T: (int)idx idv:(NSString *)idv password:(NSString *)password randomKey:(NSData *)randomKey;
- (Certificate *) issueWithRefNum_T_checkValidity:(NSString*)refNum authCode:(NSString*)authCode ip:(NSString *)ip port:(int)port password:(NSString*)password randomKey:(NSData*)randomKey caNum:(int)caNum isReIssue:(BOOL)isReIssue;
- (Certificate *) issueWithRefNum_T:(NSString*)refNum authCode:(NSString*)authCode ip:(NSString *)ip port:(int)port password:(NSString*)password randomKey:(NSData*)randomKey caNum:(int)caNum isReIssue:(BOOL)isReIssue checkValidity:(BOOL)fValid;
- (Certificate *) issueWithRefNum_T:(NSString*)refNum authCode:(NSString*)authCode ip:(NSString *)ip port:(int)port password:(NSString*)password randomKey:(NSData*)randomKey caNum:(int)caNum isReIssue:(BOOL)isReIssue;
- (Certificate *) issueWithRefNum_T:(NSString*)refNum authCode:(NSString*)authCode password:(NSString*)password randomKey:(NSData*)randomKey caName:(NSString*)caName testFlag:(NSUInteger)testFlag isReIssue:(BOOL)isReIssue;
- (Certificate *) issueWithRefNum_T:(NSString*)refNum authCode:(NSString*)authCode password:(NSString*)password randomKey:(NSData*)randomKey caName:(NSString*)caName testFlag:(NSUInteger)testFlag;
- (int) update_T_checkValidity:(int)idx password:(NSString *)password randomKey:(NSData*)randomKey ip:(NSString *)ip port:(int)port caNum:(int)caNum;
- (int) update_T:(int)idx password:(NSString *)password randomKey:(NSData*)randomKey ip:(NSString *)ip port:(int)port caNum:(int)caNum  checkValidity:(BOOL)fValid;
- (int) update_T:(int)idx password:(NSString *)password randomKey:(NSData*)randomKey ip:(NSString *)ip port:(int)port caNum:(int)caNum;
- (int) update_T:(int)idx password:(NSString *) password randomKey:(NSData*)randomKey caName:(NSString*)caName testFlag:(NSUInteger)testFlag;
- (int) updateWithChangeCertPassword_T:(int)idx oldPassword:(NSString *) oldPassword oldRandomKey:(NSData*)oldRandomKey  newPassword:(NSString *) newPassword newRandomKey:(NSData *)newRandomKey caName:(NSString*)caName testFlag:(NSUInteger)testFlag checkValidity : (BOOL) fValid;
@end


@interface CertManager(ProtectedData)
//manage labeled key
- (BOOL)addLabeledPrivateKey:(int)idx currentPW:(ProtectedData*)curPasswd newPW:(ProtectedData*)newPasswd label:(NSString *)aLabel;
- (BOOL)delLabeledPrivateKey:(int)idx label:(NSString *)aLabel;

/*  signingTime - nil : 서명시간 및 서명 attr 불포함(Default)
 - ""  : 서명시간 현재 시간으로 자동생성
 - 열자리 문자열 : 초단위
 - 13자리 문자열 : 밀리초 단위 시간을 입력받아 내부에서 초단위로 변환
 */
- (BOOL) changeCertPassword_S:(int)idx oldPassword:(ProtectedData *)oldPassword newPassword:(ProtectedData *) newPassword;
- (BOOL) changeCertPassword_S_checkValidity:(int)idx oldPassword:(ProtectedData *)oldPassword newPassword:(ProtectedData *)newPassword;
- (BOOL) changeCertPassword_S:(int)idx oldPassword:(ProtectedData *)oldPassword newPassword:(ProtectedData *)newPassword checkValidity:(BOOL)fValid;
- (int) checkCertPassword_S:(int)idx currentPassword:(ProtectedData *)currentPassword;
- (int) getVidHashContents_S: (int)idx idv:(NSString*)idv password:(ProtectedData *)password result:(char*)result;
- (int) envelopIDN_R_S:(int)idx password:(ProtectedData*)password idn:(NSString*)idn serverCert:(NSData*)aServerCert result:(char*)result;
- (NSData*) getRandomFromKey_S: (int)idx password:(ProtectedData *)password;
- (int) selfUserVerify_S: (int)idx idv:(NSString *)idv password:(ProtectedData *)password;
//전자서명 생성
- (int) cmsSign_S:(int)idx password:(ProtectedData*)password signSource:(NSData*)signSource signingTime:(NSData*)signingTime signResult:(char*)signResult;
- (int) cmsSign_S:(int)idx password:(ProtectedData*)password signSource:(NSData*)signSource signResult:(char*)signResult;
- (int) cmsSignFile_S:(int)idx password:(ProtectedData*)password fileInfo:(NSData*)fileInfo fileHash:(NSData*)fileHash signingTime:(NSData*)signingTime signResult:(char*)signResult;
- (int) cmsSignHash_S:(int)idx password:(NSString*)password hashedSignSource:(NSData*)hashedSignSource dummy:(NSData*)dummy signResult:(char*)signResult;
- (int) simpleSign_S:(int)idx password:(ProtectedData*)password signSource:(NSData*)signSource signResult:(char*)signResult;
- (int) simpleSignHash_S:(int)idx password:(ProtectedData*)password hashedSignSource:(NSData*)hashedSignSource signResult:(char*)signResult;
- (int) koscomSign_S:(int)idx password:(ProtectedData*)password signSource:(NSData*)signSource signResult:(char*)signResult;
- (int) koscomSignHash_S:(int)idx password:(ProtectedData*)password hashedSignSource:(NSData*)hashedSignSource dummy:(NSData*)dummy signResult:(char*)signResult;
- (int) koscomSimpleSign_S:(int)idx password:(ProtectedData*)password signSource:(NSData*)signSource signResult:(char*)signResult;
- (int) koscomSimpleSignHash_S:(int)idx password:(ProtectedData*)password hashedSignSource:(NSData*)hashedSignSource signResult:(char*)signResult;

- (Certificate *) issueWithRefNum_S:(NSString*)refNum authCode:(NSString*)authCode ip:(NSString *)ip port:(int)port password:(ProtectedData*)password caNum:(int)caNum isReIssue:(BOOL)isReIssue;
- (Certificate *) issueWithRefNum_S:(NSString*)refNum authCode:(NSString*)authCode password:(ProtectedData*)password caName:(NSString*)caName testFlag:(NSUInteger)testFlag;

- (int) update_S:(int)idx password:(ProtectedData *)password ip:(NSString *)ip port:(int)port caNum:(int)caNum;
- (int) update_S:(int)idx password:(ProtectedData *)password caName:(NSString*)caName testFlag:(NSUInteger)testFlag;
- (int) updateWithChangeCertPassword_S:(int)idx oldPassword:(ProtectedData *)oldPassword newPassword:(ProtectedData *)newPassword caName:(NSString *)caName testFlag:(NSUInteger)testFlag;

+ (int)checkPasswordValidity_S:(ProtectedData *)password error:(NSError**)error;
+ (int)checkPasswordValidityEx_S:(ProtectedData *)password error:(NSError**)error;


// Transkey -> SecureData
- (SecureData *) secureDataWithPassword:(NSString *)password randomKey:(NSData*)randomKey;

- (void)arrCertRelease;
@end
