#import <Foundation/Foundation.h>
#import "MessageSenderProtocol.h"

// 具体实现化：短信发送
@interface SMSMessageSender : NSObject <MessageSenderProtocol>
- (void)sendMessage:(NSString *)message toRecipient:(NSString *)recipient;

@end
