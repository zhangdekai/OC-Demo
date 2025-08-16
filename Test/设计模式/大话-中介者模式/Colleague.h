#import <Foundation/Foundation.h>
#import "MediatorProtocol.h"

// 抽象同事类
@interface Colleague : NSObject

@property (nonatomic, weak) id<MediatorProtocol> mediator;
@property (nonatomic, copy, readonly) NSString *name;

- (instancetype)initWithName:(NSString *)name;

// 发送消息
- (void)sendMessage:(NSString *)message;

// 接收消息
- (void)receiveMessage:(NSString *)message from:(NSString *)senderName;

@end
