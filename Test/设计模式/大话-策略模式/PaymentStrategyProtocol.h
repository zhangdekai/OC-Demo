#import <Foundation/Foundation.h>

// 抽象策略协议
@protocol PaymentStrategyProtocol <NSObject>

- (BOOL)payWithAmount:(CGFloat)amount;

@end
