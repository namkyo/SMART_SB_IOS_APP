//
//  SASCrypto.h
//  iSASSample2
//
//  Created by 류재욱 on 2016. 3. 30..
//  Copyright © 2016년 류재욱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASLibrary.h"

@interface SASCryptoBundle : NSObject <SASCryptoJSExports>
-(NSString*)enc:(NSString*)input;
-(JSValue*)dec:(JSValue*)input;
-(id)initWithKey:(NSString*)key;
-(id)init;
-(void)setKey:(NSString*)key;
-(void)copyFrom:(id)from;
@end

/*
@interface SASCryptoResultAES : NSObject <SASCryptoProtocol>
-(NSString*)encrypt:(NSString*)plain;
-(NSString*)decrypt:(NSString*)encrypted;
-(id)initWithKey:(NSString*)key;
@end
*/

/*
@interface SASCryptoSEED : NSObject <SASCryptoProtocol>
-(NSString*)encrypt:(NSString*)plain;
-(NSString*)decrypt:(NSString*)encrypted;
-(id)initWithKey:(NSString*)key;
@end
*/

