#import "AddExpression.h"
#import "InterpretContext.h"

@implementation AddExpression {
    id<ExpressionProtocol> _leftExpression;
    id<ExpressionProtocol> _rightExpression;
}

- (instancetype)initWithLeftExpression:(id<ExpressionProtocol>)left rightExpression:(id<ExpressionProtocol>)right {
    self = [super init];
    if (self) {
        _leftExpression = left;
        _rightExpression = right;
    }
    return self;
}

- (NSInteger)interpret:(InterpretContext *)context {
    // 先解析左右表达式，再相加
    return [_leftExpression interpret:context] + [_rightExpression interpret:context];
}

@end
