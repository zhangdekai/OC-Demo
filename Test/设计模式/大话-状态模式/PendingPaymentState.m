#import "PendingPaymentState.h"
#import "Order.h"
#import "PaidState.h"

@implementation PendingPaymentState

// PendingPaymentState 下一个状态是 PaidState，修改 state = PaidState；
- (void)payOrder:(Order *)order {
    NSLog(@"订单支付成功");
    order.state = [[PaidState alloc] init];
}

- (void)shipOrder:(Order *)order {
    NSLog(@"错误：订单尚未支付，不能发货");
}

- (void)completeOrder:(Order *)order {
    NSLog(@"错误：订单尚未支付，不能完成");
}

- (void)cancelOrder:(Order *)order {
    NSLog(@"订单已取消");
    // 这里可以设置为取消状态，简化示例暂不实现
}

- (NSString *)stateName {
    return @"待支付";
}

@end
