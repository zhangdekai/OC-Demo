#import <Foundation/Foundation.h>
#import "Product.h"

// 产品类型枚举
typedef NS_ENUM(NSInteger, ProductType) {
    ProductTypeA,
    ProductTypeB
};

// 简单工厂类
@interface SimpleFactory : NSObject

+ (id<Product>)createProductWithType:(ProductType)type;

@end
