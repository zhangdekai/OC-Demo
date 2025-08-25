#import <Foundation/Foundation.h>
#import "PaymentStrategyProtocol.h"

// 环境类
@interface PaymentContext : NSObject

- (instancetype)initWithStrategy:(id<PaymentStrategyProtocol>)strategy;

// 切换支付策略
- (void)setStrategy:(id<PaymentStrategyProtocol>)strategy;

// 执行支付
- (BOOL)executePaymentWithAmount:(CGFloat)amount;

@end
