#import "SmartHomeFacade.h"

@implementation SmartHomeFacade {
    AirConditioner *_airConditioner;
    TV *_tv;
    Curtain *_curtain;
}

- (instancetype)initWithAirConditioner:(AirConditioner *)ac
                                    tv:(TV *)tv
                               curtain:(Curtain *)curtain {
    self = [super init];
    if (self) {
        _airConditioner = ac;
        _tv = tv;
        _curtain = curtain;
    }
    return self;
}

// 回家模式：开启空调、打开窗帘、关闭电视
- (void)homeMode {
    NSLog(@"=== 启动回家模式 ===");
    [_airConditioner turnOn];
    [_airConditioner setTemperature:26.0];
    [_curtain open];
    [_tv turnOff];
    NSLog(@"=== 回家模式设置完成 ===");
}

// 离家模式：关闭所有设备
- (void)awayMode {
    NSLog(@"=== 启动离家模式 ===");
    [_airConditioner turnOff];
    [_tv turnOff];
    [_curtain close];
    NSLog(@"=== 离家模式设置完成 ===");
}

// 观影模式：关闭窗帘、开启电视、调整空调
- (void)movieMode {
    NSLog(@"=== 启动观影模式 ===");
    [_curtain close];
    [_tv turnOn];
    [_tv setChannel:5];
    [_airConditioner setTemperature:24.0];
    NSLog(@"=== 观影模式设置完成 ===");
}

@end
