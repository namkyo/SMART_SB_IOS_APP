//
//  ESSecureUserDefaults.h
//  Eversafe
//
//

#ifndef ESSecureUserDefaults_h
#define ESSecureUserDefaults_h
#import <Foundation/Foundation.h>

@interface ESSecureUserDefaults : NSObject

- (nullable id)objectForKey:(nonnull NSString *)aKey;
- (nullable NSString *)stringForKey:(nonnull NSString *)aKey;
- (nullable NSArray *)arrayForKey:(nonnull NSString *)aKey;
- (nullable NSDictionary<NSString *, id> *)dictionaryForKey:(nonnull NSString *)aKey;
- (nullable NSData *)dataForKey:(nonnull NSString *)aKey;
- (nullable NSArray<NSString *> *)stringArrayForKey:(nonnull NSString *)aKey;
- (NSInteger)integerForKey:(nonnull NSString *)aKey;
- (float)floatForKey:(nonnull NSString *)aKey;
- (double)doubleForKey:(nonnull NSString *)aKey;
- (BOOL)boolForKey:(nonnull NSString *)aKey;

- (void)setObject:(nullable id)value forKey:(nonnull NSString *)aKey;
- (void)setInteger:(NSInteger)value forKey:(nonnull NSString *)aKey;
- (void)setFloat:(float)value forKey:(nonnull NSString *)aKey;
- (void)setDouble:(double)value forKey:(nonnull NSString *)aKey;
- (void)setBool:(BOOL)value forKey:(nonnull NSString *)aKey;

- (void)removeObjectForKey:(nonnull NSString *)aKey;
- (void)removeAllObjects;
- (void)removeSecureUserDefaults;

@end
#endif
