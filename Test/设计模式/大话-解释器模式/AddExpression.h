#import <Foundation/Foundation.h>
#import "ExpressionProtocol.h"

// 加法表达式（非终结符表达式）
@interface AddExpression : NSObject <ExpressionProtocol>

- (instancetype)initWithLeftExpression:(id<ExpressionProtocol>)left rightExpression:(id<ExpressionProtocol>)right;

@end
