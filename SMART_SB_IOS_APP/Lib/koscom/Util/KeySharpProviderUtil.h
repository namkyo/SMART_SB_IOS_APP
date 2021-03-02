//
//  KeySharpProviderUtil.h
//  SMART_SB_APP_IOS
//
//  Created by 최지수 on 2021/02/22.
//

#import <UIKit/UIKit.h>

@interface KeySharpProviderUtil : NSObject
- (NSString *)koscomSign:(int)idx
                       password:(NSString*) password
                     sourceData:(NSString*) signSource
                        manager:(CertManager*) manager;

- (NSString *) getRandom:(int)idx
                password: (NSString*) password
                 manager:(CertManager*) manager;
@end
