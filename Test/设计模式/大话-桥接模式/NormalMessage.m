#import "NormalMessage.h"

@implementation NormalMessage

- (void)send:(NSString *)content to:(NSString *)recipient {
    // 普通消息直接发送
    NSString *normalContent = [NSString stringWithFormat:@"[普通消息] %@", content];
    [super send:normalContent to:recipient];
}

@end
