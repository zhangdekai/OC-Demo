#import "Colleague.h"

@implementation Colleague

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = [name copy];
    }
    return self;
}

- (void)sendMessage:(NSString *)message {
    // 通过中介者发送消息
    [self.mediator sendMessage:message from:self];
}

- (void)receiveMessage:(NSString *)message from:(NSString *)senderName {
    // 子类可以重写此方法实现具体的接收逻辑
    NSLog(@"%@ 收到来自 %@ 的消息: %@", self.name, senderName, message);
}

@end
