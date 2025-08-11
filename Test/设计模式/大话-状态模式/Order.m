#import "Order.h"
#import "PendingPaymentState.h"

@implementation Order

- (instancetype)initWithOrderId:(NSString *)orderId {
    self = [super init];
    if (self) {
        _orderId = orderId;
        // 初始状态为待支付
        _state = [[PendingPaymentState alloc] init];
    }
    return self;
}

- (void)pay {
    [self.state payOrder:self];
}

- (void)ship {
    [self.state shipOrder:self];
}

- (void)complete {
    [self.state completeOrder:self];
}

- (void)cancel {
    [self.state cancelOrder:self];
}

- (void)showCurrentState {
    NSLog(@"订单 %@ 当前状态: %@", self.orderId, [self.state stateName]);
}

@end
