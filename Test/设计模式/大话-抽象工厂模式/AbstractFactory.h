#import "AbstractProducts.h"
#import <Foundation/Foundation.h>

// 抽象工厂协议
// * 提供一个创建一系列或相关依赖对象的接口，而无需制定它们具体的类。

@protocol DeviceFactoryProtocol <NSObject>
- (id<PhoneProtocol>)createPhone;
- (id<ComputerProtocol>)createComputer;
@end
