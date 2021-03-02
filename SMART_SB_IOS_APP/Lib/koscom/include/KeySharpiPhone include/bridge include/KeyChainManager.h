//
//  KeyChainManager.h
//  CertmanagerDemo_Koscom
//
//  Created by choi sung hoon on 10. 04. 22.
//

#import <Foundation/Foundation.h>


@interface KSKeyChainManager : NSObject {
    BOOL shareOption;
    NSString* sharingGroup;
    //[2013.06.11] add
    BOOL isSofo;
    NSString *label;
}

+ (KSKeyChainManager *) sharedInstance;
- (id) initWithSharingGroup:(NSString*)sahringGroup;
- (id) initSofo;
- (id) initSofoWithSharingGroup:(NSString*)sahringGroup;
- (BOOL) saveToKeyChain:(NSData *)cert key:(NSData *)key;
- (NSArray *) loadCertFromKeyChain;
- (NSData *) loadKeyFromKeyChain: (NSData*) certData;
- (BOOL) delKeyChainItem:(NSData*)certData;
- (BOOL) updateKeyItem:(NSData *)cert newKey:(NSData *)newKey;

//added by hnkwno 2016.4.26 for label
- (BOOL) updateKeyItem:(NSData *)cert newKey:(NSData *)newKey label:(NSString*)aLabel;

- (BOOL) isItemSharable;
///////
- (NSData *) loadKeyFromKeyChain: (NSData*) certData label:(NSString*)label;
- (BOOL) addPrivateKeyWithLabel:(NSData *)cert key:(NSData *)key label:aLabel;
- (BOOL) delPrivateKeyWithLabel: (NSData*)certData label:(NSString*)aLabel;
@end
