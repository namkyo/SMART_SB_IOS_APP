//
//  iSASCore.h
//  JavaScriptSample
//
//  Created by 류재욱 on 2016. 1. 4..
//  Copyright © 2016년 류재욱. All rights reserved.

/*
IBK 연금보험(티시스), 소스 보안성 심사 
openssl.framework/Headers/objects.h
    #  define SN_md5                          "MD5"               //juryu Test
    #  define LN_md5                          "md5"               //juryu Test
    #  define NID_md5                         4                   //juryu Test
    #  define OBJ_md5                         OBJ_rsadsi,2L,5L    //juryu Test

openssl.framework/Headers/obj_mac.h
    #define SN_md5          "MD5"                 //juryu teset
    #define LN_md5          "md5"                 //juryu teset    
    #define NID_md5         4                     //juryu teset
    #define OBJ_md5         OBJ_rsadsi,2L,5L      //juryu teset

openssl.framework/Headers/ssl.h
    # define SSL_TXT_DES             "DES"        //juryu test
    # define SSL_TXT_MD5             "MD5"        //juryu test
*/

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "SASLibrary.h"

@class SASManager;

@protocol SASManagerDelegate <NSObject>
@required
-(void) onSASRunCompleted:(int)index outString:(NSString*)outString;

@optional
-(void) onSASRunStatusChanged:(int)action percent:(int)percent;
//@optional
////juryu add 2020-01-13 - for Naver
-(void) onSASLogger:(NSString*)logString;
@optional
//테스트용 셈플에서만 사용하는 함수
-(BOOL) onGetCert:(NSString*)certInfo certData:(NSData**)certData pkeyData:(NSData**)pkeyData;
//2020-11-26 onGetCallback
-(BOOL) onGetCallback:(SASManager*)owner reqData:(NSString**)certData rspData:(NSString**)pkeyData;
@end



@interface SASManager : NSObject

@property (nonatomic, retain) id<SASManagerDelegate> delegate;
@property (nonatomic, retain) NSString *input;
@property (nonatomic, retain) NSString *output;
@property int errorCode;

-(id)init;
-(NSString*)run:(int)index inString:(NSString*)inString;
-(BOOL)asyncRun:(int)index inString:(NSString*)inString;
-(NSString*)run:(int)index inString:(NSString*)inString asyncMode:(BOOL)asyncMode;
//juryu 2020-01-21 added
-(void)cancel;
-(void)reStart;

-(void)reCreateScriptManager:(NSString*)serverAddr appName:(NSString*)appName deviceInfo:(NSString*)deviceInfo;

-(void)setStatus:(int)aStatusCode aPersent:(int) aPersent;
-(void)setContextObject:(NSString*)CotextName ContextObject:(id)ContextObject;
-(void)setDebugMode:(BOOL)mode;
-(void)setResultCrypt:(id<SASCryptoProtocol>)CryptoProtocol;
-(BOOL)isSupportedOS;
-(void)setIsCustomCookieStorage:(BOOL)value;

//juryu 2019-07-29 added
-(void)setSecureKey:(NSString*)secureKey;

//juryu 2020-01-06 added
-(void)setUseTrustedCertificateStorage:(BOOL)enable;
-(BOOL)UseTrustedCertificateStorage;

+(void)thread_setup;
+(void)thread_cleanup;  // 호출하지 말것!!
+(bool)addTrustedCertificateAuthority:(NSData *)trustedCertificateAuthority isTemp:(BOOL)isTemp;

//juryu 2020-01-20 added
- (void)setUserDeviceName:(NSString*)value;
- (void)setUserOSVersion:(NSString*)value;
- (void)setUserAppVersion:(NSString*)value;
- (void)setUserInfo:(NSString*)value;

//juryu 2020-01-29 added
-(void)setBundleKey:(NSString*)key;
-(NSString*)getBundleKey;

//juryu 2020-08-12
-(void)setLoggerMode:(BOOL)mode;

-(dispatch_group_t)getDispatchGroup;

@end
