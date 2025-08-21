#import "Coffee.h"

@implementation Espresso

// 重写描述方法
- (NSString *)description {
    return @"浓缩咖啡";
}

// 重写价格方法
- (double)cost {
    return 28.0; // 浓缩咖啡基础价格
}

@end

@implementation Americano

- (NSString *)description {
    return @"美式咖啡";
}

- (double)cost {
    return 22.0; // 美式咖啡基础价格
}

@end

@implementation Latte

- (NSString *)description {
    return @"拿铁咖啡";
}

- (double)cost {
    return 30.0; // 拿铁咖啡基础价格
}

@end
