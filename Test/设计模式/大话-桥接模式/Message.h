#import <Foundation/Foundation.h>
#import "MessageSenderProtocol.h"

// 抽象化角色：消息
@interface Message : NSObject

// 桥接引用：持有实现化对象
@property (nonatomic, strong) id<MessageSenderProtocol> sender;

- (instancetype)initWithSender:(id<MessageSenderProtocol>)sender;

// 抽象方法：发送消息
- (void)send:(NSString *)content to:(NSString *)recipient;

@end
