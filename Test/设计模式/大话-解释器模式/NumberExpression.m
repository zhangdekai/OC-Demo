#import "NumberExpression.h"
#import "InterpretContext.h"

@implementation NumberExpression {
    NSInteger _number;
}

- (instancetype)initWithNumber:(NSInteger)number {
    self = [super init];
    if (self) {
        _number = number;
    }
    return self;
}

- (NSInteger)interpret:(InterpretContext *)context {
    // 数字表达式直接返回自身值，不依赖上下文
    return _number;
}

@end
