//
//  CopyCertificate.h
//  CertmanagerLib
//
//  Created by choi sung hoon on 10. 01. 19.
//

#import <Foundation/Foundation.h>


@interface CopyCertificate : NSObject {
	NSData* cert;
	NSData* key;
}

@property (nonatomic, retain) NSData* cert;
@property (nonatomic, retain) NSData* key;

- (int) getConfirmNumber_Pod: (char*)cnum SN:(NSString*)SN firstAddr:(char*)addr1 secondAddr:(char*)addr2 port:(int)port;
- (int) getConfirmNumber:(char*) cnum firstAddr:(char*)addr1 secondAddr:(char*)addr2 port:(int)port;
- (int) getCertAndKey_Pod:(int) sock SN:(NSString*) SN;
- (int) getCertAndKey:(int) sock;

@end
