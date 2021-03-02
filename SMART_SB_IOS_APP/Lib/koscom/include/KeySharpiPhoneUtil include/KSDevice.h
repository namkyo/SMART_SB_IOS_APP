
//  KSDevice.h
//  CertmanagerLibrary
//
//  Created by sjyang on 13. 9. 12..
//
//

#import <Foundation/Foundation.h>

#define KS_DEVICE_HASH_HMACSHA      1
#define KS_DEVICE_HASH_SHA1         2
#define KS_DEVICE_HASH_SHA256       3

#define KS_DEVICE_INFO_UDID         0x0000
#define KS_DEVICE_INFO_DEFAULT      0x0000
#define KS_DEVICE_INFO_NAME         0x0001
#define KS_DEVICE_INFO_SYSVERSION   0x0002
#define KS_DEVICE_INFO_MAC          0x0004

#define KS_DEVICE_INPUT_NULL        -100

#define KSD_ERR_BASE64_ENCODE_FAIL   -200
#define KSD_ERR_BASE64_DECODE_FAIL   -201
#define KSD_ERR_HEX_ENCODE_FAIL      -202
#define KSD_ERR_HEX_DECODE_FAIL      -203
#define KSD_DEVICE_INPUT_NULL        -100

#define KSD_ENCODING_BINARY 1
#define KSD_ENCODING_BASE64 2
#define KSD_ENCODING_HEXUP  3
#define KSD_ENCODING_HEXLOW 4

@interface KSDevice : NSObject {
    int algId;
    int hashLen;
    unsigned char mackey[16];
    
    NSString *deviceId;
    NSString *sharingGroup;
}
@property (nonatomic, retain) NSString* sharingGroup;

- (id)initWithAlgorithm:(int)hashId mackey:(char *)key;
- (int)setId:(NSString *)aDeviceId forKey:(NSString *)devIdKey;
- (NSString *)getIdForKey:(NSString *)devIdKey;
- (void)resetIdForKey:(NSString *)devIdKey;

//hash
- (NSString *)getUUIDIsHashed:(BOOL)isHashed;
- (NSString *)getDeviceNameIsHashed:(BOOL)isHashed;
- (NSString *)getSystemVersionIsHashed:(BOOL)isHashed;
- (NSString *)getCellularProviderIsHashed:(BOOL)isHashed;

- (NSString *)hashData:(NSString *)data;

+ (NSString *)UUID;
+ (NSString *)UDID;//save uuid to "standardUserDefaults"
@end
