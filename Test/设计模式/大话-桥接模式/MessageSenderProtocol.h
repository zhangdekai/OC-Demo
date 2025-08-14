#import <Foundation/Foundation.h>

// 实现化接口：定义发送消息的基本操作
@protocol MessageSenderProtocol <NSObject>

- (void)sendMessage:(NSString *)message toRecipient:(NSString *)recipient;

@end
