#import <Foundation/Foundation.h>
#import "ProductFactoryProtocol.h"

// 工厂协议
@protocol FactoryProtocol <NSObject>
- (id<ProductFactoryProtocol>)createProduct;
@end
