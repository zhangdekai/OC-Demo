#import "Publisher.h"
#import "PublishSubscribeCenter.h"

@implementation Publisher

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

- (void)publishMessage:(id)message toTopic:(NSString *)topic {
    NSLog(@"%@ 发布消息到主题 <%@>: %@", self.name, topic, message);
    [[PublishSubscribeCenter sharedCenter] publishToTopic:topic message:message];
}

@end
    