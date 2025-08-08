#import <Foundation/Foundation.h>

// 抽象父类：饮料
@interface Beverage : NSObject

// 模板方法：定义制作饮料的流程（算法骨架）
- (void)prepareRecipe;

// 抽象方法：由子类实现具体步骤
- (void)brew;         // 冲泡
- (void)addCondiments; // 加配料

// 具体方法：所有子类共享的步骤
- (void)boilWater;    // 煮水
- (void)pourInCup;    // 倒入杯子

@end
    