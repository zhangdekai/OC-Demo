#import "ChatRoomMediator.h"

@implementation ChatRoomMediator {
    NSMutableArray<Colleague *> *_colleagues; // 存储所有同事
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _colleagues = [NSMutableArray array];
    }
    return self;
}

- (void)registerColleague:(Colleague *)colleague {
    if (colleague && ![ _colleagues containsObject:colleague ]) {
        [_colleagues addObject:colleague];
        colleague.mediator = self; // 设置中介者
    }
}

- (void)sendMessage:(NSString *)message from:(Colleague *)sender {
    if (!message || !sender) return;
    
    // 将消息转发给除发送者外的所有同事
    for (Colleague *colleague in _colleagues) {
        if (colleague != sender) {
            [colleague receiveMessage:message from:sender.name];
        }
    }
}

@end
