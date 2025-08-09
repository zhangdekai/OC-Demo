#import <Foundation/Foundation.h>
#import "AirConditioner.h"
#import "TV.h"
#import "Curtain.h"
#import "SmartHomeFacade.h"

int testFacadeMain(void) {
    @autoreleasepool {
        // 创建子系统实例
        AirConditioner *ac = [[AirConditioner alloc] init];
        TV *tv = [[TV alloc] init];
        Curtain *curtain = [[Curtain alloc] init];
        
        // 创建外观类
        SmartHomeFacade *homeFacade = [[SmartHomeFacade alloc]
                                     initWithAirConditioner:ac
                                     tv:tv
                                     curtain:curtain];
        
        // 客户端通过外观类操作，无需关心子系统细节
        [homeFacade homeMode];    // 回家
        NSLog(@"\n--- 一段时间后 ---");
        [homeFacade movieMode];   // 看电影
        NSLog(@"\n--- 电影结束，准备外出 ---");
        [homeFacade awayMode];    // 离家
    }
    return 0;
}
