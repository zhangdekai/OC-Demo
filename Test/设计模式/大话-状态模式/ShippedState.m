#import "ShippedState.h"
#import "Order.h"
#import "CompletedState.h"

@implementation ShippedState

- (void)payOrder:(Order *)order {
    NSLog(@"错误：订单已支付，无需重复支付");
}

- (void)shipOrder:(Order *)order {
    NSLog(@"错误：订单已发货，不能重复发货");
}

- (void)completeOrder:(Order *)order {
    NSLog(@"订单已完成");
    order.state = [[CompletedState alloc] init];
}

- (void)cancelOrder:(Order *)order {
    NSLog(@"错误：订单已发货，不能取消");
}

- (NSString *)stateName {
    return @"已发货";
}

@end
