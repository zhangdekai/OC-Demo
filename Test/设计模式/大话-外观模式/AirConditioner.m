#import "AirConditioner.h"

@implementation AirConditioner

- (void)turnOn {
    NSLog(@"空调已开启");
}

- (void)turnOff {
    NSLog(@"空调已关闭");
}

- (void)setTemperature:(float)temp {
    NSLog(@"空调温度设置为: %.1f℃", temp);
}

@end
