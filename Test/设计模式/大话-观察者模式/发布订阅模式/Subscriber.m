#import "Subscriber.h"
#import "PublishSubscribeCenter.h"

@implementation Subscriber

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

- (void)subscribeToTopic:(NSString *)topic {
    NSLog(@"%@ 订阅了主题 <%@>", self.name, topic);
    [[PublishSubscribeCenter sharedCenter] subscribeToTopic:topic 
                                                subscriber:self 
                                                    block:^(id message) {
        NSLog(@"%@ 收到主题 <%@> 的消息: %@", self.name, topic, message);
    }];
}

- (void)unsubscribeFromTopic:(NSString *)topic {
    NSLog(@"%@ 取消订阅主题 <%@>", self.name, topic);
    [[PublishSubscribeCenter sharedCenter] unsubscribeFromTopic:topic 
                                                    subscriber:self];
}

- (void)unsubscribeAll {
    NSLog(@"%@ 取消所有订阅", self.name);
    [[PublishSubscribeCenter sharedCenter] unsubscribeAllForSubscriber:self];
}

@end
    