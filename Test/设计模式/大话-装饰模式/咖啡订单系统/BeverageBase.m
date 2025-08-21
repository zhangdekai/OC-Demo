#import "BeverageBase.h"

@implementation BeverageBase

// 基类默认实现，子类应重写这些方法
- (NSString *)description {
    return @"未知饮料";
}

- (double)cost {
    return 0.0;
}

@end
