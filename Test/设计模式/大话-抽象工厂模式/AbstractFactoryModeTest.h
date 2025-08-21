#import <Foundation/Foundation.h>
#import "ConcreteFactories.h"

// 客户端使用函数
void useDevices(id<DeviceFactoryProtocol> factory) {
    id<PhoneProtocol> phone = [factory createPhone];
    id<ComputerProtocol> computer = [factory createComputer];
    
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
