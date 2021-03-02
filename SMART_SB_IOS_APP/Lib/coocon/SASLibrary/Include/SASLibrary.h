//
//  SASLibrary.h
//  JavaScriptSample
//
//  Created by 류재욱 on 2016. 2. 18..
//  Copyright © 2016년 류재욱. All rights reserved.
//

#ifndef SASLibrary_h
#define SASLibrary_h

#import <JavaScriptCore/JSExport.h>

/*
 Input Param Crypto
 
스크립트에 노출될 Object 명 : Crypto

제공함수 :
string enc(string)
string dec(string)

키는 APP에 설정가능하고 스크립트는 관여하지 않음.

freeFix는 OS별로 지정해서 사용(알고리즘이 여러개일 경우 확장 가능하도록)
예) "|1234SASCRYPTOMSGabc|"
 
*/
@protocol SASCryptoJSExports <JSExport>
JSExportAs(enc,
           -(NSString*)enc:(NSString*)input
           );
JSExportAs(dec,
           -(JSValue*)dec:(JSValue*)input
           );
@end;

/*
 
 Output Param Crypto
 
 */
@protocol SASCryptoProtocol <JSExport>
-(NSString*)encrypt:(NSString*)plain;
-(NSString*)decrypt:(NSString*)encrypted;
@end;


//FIDO Callback Protocol
@protocol SASFidoProtocol <JSExport>
JSExportAs(getP7XecureData,
    -(NSString*)getP7XecureData:(NSString*)plain charset:(NSString*)charset // for Xecure
);
JSExportAs(getP7Data,  
    -(NSString*)getP7Data:(NSString*)plain charset:(NSString*)charset    // for IniSafe & etc
);
JSExportAs(getP1Data,
    -(NSString*)getP1Data:(NSString*)plain charset:(NSString*)charset    // for IniSafe & etc
);
-(NSString*)getPublicKey;
-(NSString*)getIDRandom;
@end;

@interface SASSecurData : NSObject
-(void)setSecureKey:(NSString*)secureKey;
-(NSString*)sasEncSecureData:(const unsigned char*)planChar planLen:(int)planLen;
-(NSString*)sasEncSecureDataWithWipe:(const unsigned char**)planChar planLen:(int)planLen;
@end;


#endif /* SASLibrary_h */
