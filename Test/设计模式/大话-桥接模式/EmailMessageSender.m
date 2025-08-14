#import "EmailMessageSender.h"

@implementation EmailMessageSender

- (void)sendMessage:(NSString *)message toRecipient:(NSString *)recipient {
    NSLog(@"通过邮件发送给 %@: %@", recipient, message);
}

@end
