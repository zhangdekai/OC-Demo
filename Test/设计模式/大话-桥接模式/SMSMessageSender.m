#import "SMSMessageSender.h"

@implementation SMSMessageSender

- (void)sendMessage:(NSString *)message toRecipient:(NSString *)recipient {
    NSLog(@"通过短信发送给 %@: %@", recipient, message);
}

@end
