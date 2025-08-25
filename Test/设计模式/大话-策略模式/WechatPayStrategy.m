#import "WechatPayStrategy.h"

@implementation WechatPayStrategy

- (BOOL)payWithAmount:(CGFloat)amount {
    NSLog(@"使用微信支付: ¥%.2f", amount);
    // 这里实现微信支付的具体逻辑
    return YES;
}

@end
