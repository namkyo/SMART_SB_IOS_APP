//
//  ixcSecuLogMaster.h
//  SecuLogMaster
//
//  Created by Ko Jaewan on 13. 5. 21..
//  Copyright (c) 2013년 INCA Internet INC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kCMD_GET_UUID = 0x300,
    kCMD_GET_OS_VERSION,
    kCMD_GET_DEVICE_MODEL,
    kCMD_GET_CARRIER_NAME,
    kCMD_GET_MCC,
    kCMD_GET_MNC,
    kCMD_GET_CALL_STATE,
    kCMD_GET_NETWORK_INFO,
    kCMD_GET_MAC_ADDRESS,
    kCMD_GET_IS_JAILBROKEN,
    kCMD_GET_SOFTWARE_INFO,
    
//#if defined(COLLECT_IP_ADDRESS)
    kCMD_GET_ETH0_IP,
    kCMD_GET_ETH1_IP,
    kCMD_GET_ETH0_GIP,
    kCMD_GET_ETH1_GIP,
//#if defined(COLLECT_NAT_IP)
    kCMD_GET_NAT_IP,
//#endif
//#endif
//#if defined(COLLECT_OS_LOCALE)
    kCMD_GET_OS_LOCALE,
//#endif
} eCOLLECT_COMMAND;

@interface ixcSecuLogMaster : NSObject
{
}

- (void)enableNatIp:(BOOL)enable;
- (void)setCheckApp:(NSString *)appPackageName;
- (BOOL)setServerKey:(NSString *)key;

- (NSString *)getEveryLog;
- (NSString *)getBuiltKey;

- (NSString *)getEveryLogByString;
- (NSDictionary *)getEveryLogByDictionary;
- (NSDictionary *)getEveryLogWithPadding;
- (NSArray *)getSortedKeys;

// For TEST
- (void)probeDeviceInfo;
- (NSString *)getLogData:(eCOLLECT_COMMAND)nLogIndex;

@end
