#import <Foundation/Foundation.h>
#import "ExpressionProtocol.h"

// 减法表达式（非终结符表达式）
@interface SubtractExpression : NSObject <ExpressionProtocol>

- (instancetype)initWithLeftExpression:(id<ExpressionProtocol>)left rightExpression:(id<ExpressionProtocol>)right;

@end
