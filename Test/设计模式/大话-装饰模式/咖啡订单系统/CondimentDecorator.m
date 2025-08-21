#import "CondimentDecorator.h"

@implementation CondimentDecorator

// 初始化时保存被装饰的饮料对象
- (instancetype)initWithBeverage:(BeverageBase *)beverage {
    self = [super init];
    if (self) {
        _beverage = beverage;
    }
    return self;
}

// 默认使用被装饰对象的描述
- (NSString *)description {
    return self.beverage.description;
}

// 默认使用被装饰对象的价格
- (double)cost {
    return self.beverage.cost;
}

@end
