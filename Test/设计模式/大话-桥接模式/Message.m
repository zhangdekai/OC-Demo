#import "Message.h"

@implementation Message

- (instancetype)initWithSender:(id<MessageSenderProtocol>)sender {
    self = [super init];
    if (self) {
        _sender = sender;
    }
    return self;
}

- (void)send:(NSString *)content to:(NSString *)recipient {
    // 委托给实现化对象处理
    [self.sender sendMessage:content toRecipient:recipient];
}

@end
