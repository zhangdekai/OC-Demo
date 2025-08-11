#import <Foundation/Foundation.h>
#import "AbstractFactory.h"

// 苹果工厂
@interface AppleFactory : NSObject <DeviceFactory>
@end

// 华为工厂
@interface HuaweiFactory : NSObject <DeviceFactory>
@end
