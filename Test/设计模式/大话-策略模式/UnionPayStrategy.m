#import "UnionPayStrategy.h"

@implementation UnionPayStrategy

- (BOOL)payWithAmount:(CGFloat)amount {
    NSLog(@"使用银联支付: ¥%.2f", amount);
    // 这里实现银联支付的具体逻辑
    return YES;
}

@end
