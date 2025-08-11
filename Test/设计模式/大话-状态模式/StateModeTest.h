#import <Foundation/Foundation.h>
#import "Order.h"

int testStateModeMain(void) {
    @autoreleasepool {
        // 创建订单
        Order *order = [[Order alloc] initWithOrderId:@"ORD123456"];
        [order showCurrentState];
        
        // 尝试发货（此时订单未支付，应该失败）
        [order ship];
        
        // 支付订单
        [order pay];
        [order showCurrentState];
        
        // 发货
        [order ship];
        [order showCurrentState];
        
        // 完成订单
        [order complete];
        [order showCurrentState];
        
        // 尝试取消已完成的订单（应该失败）
        [order cancel];
    }
    return 0;
}
