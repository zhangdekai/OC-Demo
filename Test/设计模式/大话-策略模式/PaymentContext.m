#import "PaymentContext.h"

@interface PaymentContext ()

@property (nonatomic, strong) id<PaymentStrategyProtocol> strategy;

@end

@implementation PaymentContext

- (instancetype)initWithStrategy:(id<PaymentStrategyProtocol>)strategy {
    self = [super init];
    if (self) {
        _strategy = strategy;
    }
    return self;
}

- (void)setStrategy:(id<PaymentStrategyProtocol>)strategy {
    _strategy = strategy;
}

- (BOOL)executePaymentWithAmount:(CGFloat)amount {
    if (!self.strategy) {
        NSLog(@"未设置支付策略");
        return NO;
    }
    return [self.strategy payWithAmount:amount];
}

@end
