//
//  ExportCertificate.h
//  CertmanagerLib
//
//  Created by choi sung hoon on 11. 10. 25..
//  Copyright 2011 lumensoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#define KS_ICRP_SHA1        0
#define KS_ICRP_SHA2        1
#define NET_INVALID_TYPE -500
#define NET_CONN_FAIL -1000
#define NET_RECV_FAIL -1001
#define NET_SEND_FAIL -1002

#define ICRP_ERR_IMPORT                     -1100
#define ICRP_ERR_IMPORT_INVALID_CERT        ICRP_ERR_IMPORT-1
#define ICRP_ERR_IMPORT_INVALID_KEY         ICRP_ERR_IMPORT-2
#define ICRP_ERR_IMPORT_INVALID_KMCERT      ICRP_ERR_IMPORT-3
#define ICRP_ERR_IMPORT_INVALID_KMKEY       ICRP_ERR_IMPORT-4

#define ICRP_ERR_EXPORT                     -1200
#define ICRP_ERR_EXPORT_INVALID_CERT        ICRP_ERR_EXPORT-1
#define ICRP_ERR_EXPORT_INVALID_KEY         ICRP_ERR_EXPORT-2
#define ICRP_ERR_EXPORT_INVALID_KMCERT      ICRP_ERR_EXPORT-3
#define ICRP_ERR_EXPORT_INVALID_KMKEY       ICRP_ERR_EXPORT-4
#define ICRP_ERR_EXPORT_FAIL_TO_DECRYPT     ICRP_ERR_EXPORT-5

//fefined in the client
#define CODE_ERR_SAVE_CERT      @"CM100"

//below are defined in the server
#define CODE_ERR_CONNECTION     @"NT100"
#define CODE_ERR_SOCKET         @"NT101"
#define CODE_ERR_BIND           @"NT102"
#define CODE_ERR_LISTERN        @"NT103"
#define CODE_ERR_ACCEPT         @"NT104"
#define CODE_ERR_WRITE          @"NT105"
#define CODE_ERR_READ           @"NT106"

#define CODE_ERR_SHOULD_R1_First    @"NL108"

#define CODE_ERR_DBOPEN         @"DB107"
#define CODE_ERR_INSERT         @"DB108"
#define CODE_ERR_DELETE         @"DB109"
#define CODE_ERR_UPDATE         @"DB110"
#define CODE_ERR_SELECT         @"DB111"
#define CADE_ERR_DBEXEC         @"DB112"

#define CODE_ERR_INVALID_INPUT  @"PT113"
#define CODE_ERR_INVALID_TYPE   @"PT114"
#define CODE_ERR_NO_CERTIFICATE @"PT115"
#define CODE_ERR_TIMEOUT        @"PT116"
#define CODE_ERR_NO_EXIST_INDEX @"PT117"
#define CODE_ERR_EXIST_INDEX    @"PT118"

#define CODE_SUCC_R1            @"SC200"
#define CODE_SUCC_R2            @"SC201"
#define CODE_SUCC_S1            @"SC202"
#define CODE_SUCC_S2            @"SC203"

#import "SecureData.h"

@interface ICRProtocol : NSObject {
    NSString* lastErrorCode;
    NSString* lastErrorMessage;
    NSString* generatedNumber;
    NSData* seed;
    NSData* index;
    NSData* key;
    NSData* iv;
    NSString* serverIP;
    NSUInteger serverPort;
    NSData *siteCodeData;
    NSData* certData;
    NSData* keyData;
    NSData* kmCertData;
    NSData* kmKeyData;
    
    int     securityLevel;
}

@property (nonatomic, retain) NSString* lastErrorCode;
@property (nonatomic, retain) NSString* lastErrorMessage;
@property (nonatomic, retain) NSString* generatedNumber;
@property (nonatomic, retain) NSData* certData;
@property (nonatomic, retain) NSData* keyData;
@property (nonatomic, retain) NSData* kmCertData;
@property (nonatomic, retain) NSData* kmKeyData;
@property (nonatomic, retain) NSString* serverIP;
@property (readwrite) NSUInteger serverPort;

@property (assign) int securityLevel;

//User Interface
- (id) initWithIP:(NSString*)ip port:(NSUInteger)port;
- (id) initWithIP:(NSString*)ip port:(NSUInteger)port siteCode:(NSString *)aSiteCode;
- (int) import1;
- (int) import2;
- (int) export1:(NSData*)exportCert exportKey:(NSData*)exportKey confirmNumber:(NSString*)confirumNumber;
- (int) export1:(NSData*)exportCert exportKey:(NSData*)exportKey kmCert:(NSData *)kmCert kmKey:(NSData *)kmKey confirmNumber:(NSString *)confirumNumber certDN:(NSString *)certDn;
+ (BOOL)checkPassword:(NSString *)password importCert:(NSData*)importCert importKey:(NSData*)importKey;
+ (BOOL)checkPassword_S:(SecureData *)password importCert:(NSData*)importCert importKey:(NSData*)importKey;
+ (BOOL)checkPassword_T:(NSString *)password randomKey:(NSData*)randomKey importCert:(NSData*)importCert importKey:(NSData*)importKey;

//Internal Functions
- (NSString*) generateRandomNumber:(int)size;
- (void) keyDerivationFunction:(NSData*)seedData count:(int)count;
- (void) indexDerivationFunction:(NSData*)seedData;

- (int) connectToServer:(char*)ip port:(NSUInteger)port timeout:(NSUInteger)timeout;
- (int) sendDataWithHeader:(int)sock type:(NSString*)type message:(NSData*)message;
- (NSData*) receiveDataWithHeader:(int)sock type:(NSString*)type;
- (int) parseTheResult:(unsigned char*)message type:(NSString *)typeString;
- (void) initialize;
@end
