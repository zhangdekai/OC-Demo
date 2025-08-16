#import "ChatUser.h"

@implementation ChatUser

// 可以重写接收消息的方法，实现个性化的消息处理
- (void)receiveMessage:(NSString *)message from:(NSString *)senderName {
    NSLog(@"【%@的聊天窗口】收到 %@: %@", self.name, senderName, message);
}

@end
