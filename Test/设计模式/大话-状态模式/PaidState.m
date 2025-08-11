#import "PaidState.h"
#import "Order.h"
#import "ShippedState.h"
#import "PendingPaymentState.h"

@implementation PaidState

- (void)payOrder:(Order *)order {
    NSLog(@"错误：订单已支付，无需重复支付");
}

- (void)shipOrder:(Order *)order {
    NSLog(@"订单已发货");
    order.state = [[ShippedState alloc] init];
}

- (void)completeOrder:(Order *)order {
    NSLog(@"错误：订单尚未发货，不能完成");
}

- (void)cancelOrder:(Order *)order {
    NSLog(@"订单已取消，正在退款...");
    order.state = [[PendingPaymentState alloc] init];
}

- (NSString *)stateName {
    return @"已支付";
}

@end
