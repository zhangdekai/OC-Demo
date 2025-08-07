#import <Foundation/Foundation.h>
#import "Product.h"

// 工厂协议
@protocol Factory <NSObject>
- (id<Product>)createProduct;
@end
