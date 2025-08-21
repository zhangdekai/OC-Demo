#import <Foundation/Foundation.h>
#import "AbstractProducts.h"

// 苹果手机
@interface IPhone : NSObject <PhoneProtocol>
@end

// 苹果电脑
@interface Mac : NSObject <ComputerProtocol>
@end

// 华为手机
@interface HuaweiPhone : NSObject <PhoneProtocol>
@end

// 华为电脑
@interface HuaweiComputer : NSObject <ComputerProtocol>
@end
