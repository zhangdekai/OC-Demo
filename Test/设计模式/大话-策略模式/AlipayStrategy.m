#import "AlipayStrategy.h"

@implementation AlipayStrategy

- (BOOL)payWithAmount:(CGFloat)amount {
    NSLog(@"使用支付宝支付: ¥%.2f", amount);
    // 这里实现支付宝支付的具体逻辑
    return YES;
}

@end
