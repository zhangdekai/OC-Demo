#import "CompletedState.h"
#import "Order.h"

@implementation CompletedState

- (void)payOrder:(Order *)order {
    NSLog(@"错误：订单已完成，无需支付");
}

- (void)shipOrder:(Order *)order {
    NSLog(@"错误：订单已完成，不能发货");
}

- (void)completeOrder:(Order *)order {
    NSLog(@"错误：订单已完成，不能重复完成");
}

- (void)cancelOrder:(Order *)order {
    NSLog(@"错误：订单已完成，不能取消");
}

- (NSString *)stateName {
    return @"已完成";
}

@end
