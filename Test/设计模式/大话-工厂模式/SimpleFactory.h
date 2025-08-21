#import <Foundation/Foundation.h>
#import "ProductFactoryProtocol.h"

// 产品类型枚举
typedef NS_ENUM(NSInteger, ProductType) {
    ProductTypeA,
    ProductTypeB
};

// 简单工厂类
@interface SimpleFactory : NSObject

+ (id<ProductFactoryProtocol>)createProductWithType:(ProductType)type;

@end
