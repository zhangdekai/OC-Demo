#import <Foundation/Foundation.h>

// 上下文类，存储变量和相关信息
@interface InterpretContext : NSObject

- (void)setVariable:(NSString *)name value:(NSInteger)value;

- (NSInteger)getVariable:(NSString *)name;

@end
