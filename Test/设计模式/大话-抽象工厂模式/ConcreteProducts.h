#import <Foundation/Foundation.h>
#import "AbstractProducts.h"

// 苹果手机
@interface IPhone : NSObject <Phone>
@end

// 苹果电脑
@interface Mac : NSObject <Computer>
@end

// 华为手机
@interface HuaweiPhone : NSObject <Phone>
@end

// 华为电脑
@interface HuaweiComputer : NSObject <Computer>
@end
