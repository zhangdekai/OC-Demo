#import <Foundation/Foundation.h>

@class Colleague;

// 抽象中介者协议
@protocol MediatorProtocol <NSObject>

// 注册同事
- (void)registerColleague:(Colleague *)colleague;

// 转发消息
- (void)sendMessage:(NSString *)message from:(Colleague *)sender;

@end
