#import <Foundation/Foundation.h>

@class Order;

// 订单状态协议
@protocol OrderState <NSObject>

// 支付订单
- (void)payOrder:(Order *)order;

// 发货
- (void)shipOrder:(Order *)order;

// 完成订单
- (void)completeOrder:(Order *)order;

// 取消订单
- (void)cancelOrder:(Order *)order;

// 获取当前状态名称
- (NSString *)stateName;

@end
