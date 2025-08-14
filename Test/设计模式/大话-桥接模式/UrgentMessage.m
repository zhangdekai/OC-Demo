#import "UrgentMessage.h"

@implementation UrgentMessage

- (void)send:(NSString *)content to:(NSString *)recipient {
    // 紧急消息添加特殊标记
    NSString *urgentContent = [NSString stringWithFormat:@"[紧急消息] %@ (请立即查看)", content];
    [super send:urgentContent to:recipient];
    
    // 紧急消息额外逻辑：发送后再次提醒
    NSLog(@"已向 %@ 发送紧急消息提醒", recipient);
}

@end
