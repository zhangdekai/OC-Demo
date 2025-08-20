#import "Tourist.h"
#import "Lion.h"
#import "Elephant.h"
#import "Monkey.h"

@implementation Tourist

// 访问狮子
- (void)visitLion:(Lion *)lion {
    NSLog(@"游客观察狮子 %@ - 拍照并观看狮子吼叫", lion.name);
}

// 访问大象
- (void)visitElephant:(Elephant *)elephant {
    NSLog(@"游客观察大象 %@ - 给大象喂食并观看它喷水", elephant.name);
}

// 访问猴子
- (void)visitMonkey:(Monkey *)monkey {
    NSLog(@"游客观察猴子 %@ - 观看猴子爬树和玩耍", monkey.name);
}

@end
