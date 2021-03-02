//
//  EversafeThreat.h
//  iOSPlay
//
//  Copyright © 2015 Everspin. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @desc 보안 위협에 대한 정보를 나타내는 클래스
 */
@interface EversafeThreat : NSObject

/*!
 * @desc 발생한 보안 위협에 대한 코드
 */
@property NSString *code;

/*!
 * @desc 발생한 보안 위협에 대한 설명
 */
@property NSString *localizedDescription;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
