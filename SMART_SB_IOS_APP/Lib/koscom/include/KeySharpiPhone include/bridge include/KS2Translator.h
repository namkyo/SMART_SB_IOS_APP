//
//  Translator.h
//  CertmanagerLibrary
//
//  Created by sjyang on 2015. 2. 2..
//  Copyright (c) 2015년 kim junhwan. All rights reserved.
//

#define TYPE_LANGUAGE_KR 0
#define TYPE_LANGUAGE_EN 1

@interface Translator : NSObject {
}
- (void) translatorPolicy:(int)langType; //getCertificatePolicyTranslator:(int)lnagType;를 통해서만 호출
@end
