#import <Foundation/Foundation.h>
#import "ConcreteFactories.h"

// 客户端使用函数
void useDevices(id<DeviceFactory> factory) {
    id<Phone> phone = [factory createPhone];
    id<Computer> computer = [factory createComputer];
    
    [phone makeCall];
    [phone takePhoto];
    [computer surfInternet];
    [computer editDocument];
}

int testAbstractFactoryMain(void) {
    @autoreleasepool {
        NSLog(@"=== 使用苹果设备 ===");
        useDevices([[AppleFactory alloc] init]);
        
        NSLog(@"=== 使用华为设备 ===");
        useDevices([[HuaweiFactory alloc] init]);
    }
    return 0;
}
