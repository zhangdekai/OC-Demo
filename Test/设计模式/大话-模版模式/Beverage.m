#import "Beverage.h"

@implementation Beverage

// 模板方法：固定算法流程
- (void)prepareRecipe {
    [self boilWater];    // 步骤1：煮水（固定）
    [self brew];         // 步骤2：冲泡（子类实现）
    [self pourInCup];    // 步骤3：倒入杯子（固定）
    [self addCondiments];// 步骤4：加配料（子类实现）
}

// 具体实现：煮水
- (void)boilWater {
    NSLog(@"将水煮沸");
}

// 具体实现：倒入杯子
- (void)pourInCup {
    NSLog(@"倒入杯子中");
}

// 抽象方法：子类必须实现
- (void)brew {
    // 子类实现
}

- (void)addCondiments {
    // 子类实现
}

@end
    
