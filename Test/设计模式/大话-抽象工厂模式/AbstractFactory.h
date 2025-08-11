#import "AbstractProducts.h"
#import <Foundation/Foundation.h>

// 抽象工厂协议
@protocol DeviceFactory <NSObject>
- (id<Phone>)createPhone;
- (id<Computer>)createComputer;
@end
