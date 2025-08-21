#import "ConcreteCondiments.h"

@implementation Milk

// 重写描述方法，在原有描述基础上添加牛奶
- (NSString *)description {
    return [NSString stringWithFormat:@"%@ + 牛奶", self.beverage.description];
}

// 重写价格方法，在原有价格基础上添加牛奶的价格
- (double)cost {
    return self.beverage.cost + 5.0; // 牛奶价格
}

@end

@implementation Sugar

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ + 糖", self.beverage.description];
}

- (double)cost {
    return self.beverage.cost + 1.0; // 糖的价格
}

@end

@implementation Chocolate

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ + 巧克力", self.beverage.description];
}

- (double)cost {
    return self.beverage.cost + 8.0; // 巧克力价格
}

@end

@implementation Foam

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ + 奶泡", self.beverage.description];
}

- (double)cost {
    return self.beverage.cost + 3.0; // 奶泡价格
}

@end
