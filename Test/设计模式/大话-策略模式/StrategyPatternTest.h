#import "PaymentContext.h"
#import "AlipayStrategy.h"
#import "WechatPayStrategy.h"
#import "UnionPayStrategy.h"

// 客户端使用示例
void testPaymentStrategy(void) {
    
    NSLog(@",,,,,  策略模式 ，，，，\n");
    // 创建支付上下文，初始使用支付宝策略
    PaymentContext *paymentContext = [[PaymentContext alloc] initWithStrategy:[[AlipayStrategy alloc] init]];
    
    // 支付100元
    [paymentContext executePaymentWithAmount:100.0];
    
    // 切换到微信支付策略
    [paymentContext setStrategy:[[WechatPayStrategy alloc] init]];
    [paymentContext executePaymentWithAmount:200.5];
    
    // 切换到银联支付策略
    [paymentContext setStrategy:[[UnionPayStrategy alloc] init]];
    [paymentContext executePaymentWithAmount:50.0];
}
