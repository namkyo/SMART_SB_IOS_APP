//
//  KStcp.h
//  CertmanagerLibrary
//
//  Created by sjyang on 2016. 1. 13..
//  Copyright © 2016년 lee minsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSdefine.h"

@interface KStcp : NSObject <NSStreamDelegate>{
    
}
@property (readonly)    int errorCode;//be privated?
- (instancetype)initWithHost:(NSString *)host port:(int)port;
//- (int)connect;//return 1 : NSStream.streamError.code or error code
- (int)connectWithTimeout:(int)second;
- (int)sendData:(NSData *)data;
- (int)recvData:(ks_uint8 *)buf len:(int)bufLen;
@end
