#import <Foundation/Foundation.h>
#import "OrderState.h"

// 订单类
@interface Order : NSObject

@property (nonatomic, strong) id<OrderState> state;
@property (nonatomic, copy) NSString *orderId;

- (instancetype)initWithOrderId:(NSString *)orderId;

// 支付订单
- (void)pay;

// 发货
- (void)ship;

// 完成订单
- (void)complete;

// 取消订单
- (void)cancel;

// 显示当前状态
- (void)showCurrentState;

@end
