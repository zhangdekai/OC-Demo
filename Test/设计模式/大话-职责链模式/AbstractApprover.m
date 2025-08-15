#import "AbstractApprover.h"

@implementation AbstractApprover

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

- (void)approve:(CGFloat)amount {
    // 抽象方法，由子类实现
}

@end
