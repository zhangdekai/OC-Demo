#import "Veterinarian.h"
#import "Lion.h"
#import "Elephant.h"
#import "Monkey.h"

@implementation Veterinarian

// 访问狮子
- (void)visitLion:(Lion *)lion {
    NSLog(@"兽医检查狮子 %@ (年龄: %ld岁) - 检查牙齿和爪子健康状况", lion.name, (long)lion.age);
}

// 访问大象
- (void)visitElephant:(Elephant *)elephant {
    NSLog(@"兽医检查大象 %@ (体重: %ldkg) - 检查象牙和皮肤状况", elephant.name, (long)elephant.weight);
}

// 访问猴子
- (void)visitMonkey:(Monkey *)monkey {
    NSLog(@"兽医检查猴子 %@ (身高: %ldcm) - 检查尾巴和活动能力", monkey.name, (long)monkey.height);
}

@end
