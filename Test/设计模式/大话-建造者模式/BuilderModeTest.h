#import <Foundation/Foundation.h>
#import "Director.h"
#import "MacBookBuilder.h"
#import "ThinkPadBuilder.h"

int testBuilderModeMain(void) {
    @autoreleasepool {
        // 1. 创建指挥者
        Director *director = [[Director alloc] init];
        
        // 2. 构建MacBook
        MacBookBuilder *macBuilder = [[MacBookBuilder alloc] init];
        [director constructWithBuilder:macBuilder];
        Computer *mac = [macBuilder getComputer];
        NSLog(@"MacBook配置：\n%@", mac.description);
        
        // 3. 构建ThinkPad
        ThinkPadBuilder *thinkBuilder = [[ThinkPadBuilder alloc] init];
        [director constructWithBuilder:thinkBuilder];
        Computer *thinkPad = [thinkBuilder getComputer];
        NSLog(@"ThinkPad配置：\n%@", thinkPad.description);
    }
    return 0;
}
