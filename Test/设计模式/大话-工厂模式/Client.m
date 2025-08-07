#import <Foundation/Foundation.h>
#import "SimpleFactory.h"
#import "ConcreteFactoryA.h"
#import "ConcreteFactoryB.h"

int testMain(int argc, const char * argv[]) {
    @autoreleasepool {
        // 使用简单工厂创建产品A
        id<Product> productA = [SimpleFactory createProductWithType:ProductTypeA];
        [productA operation];
        
        // 使用简单工厂创建产品B
        id<Product> productB = [SimpleFactory createProductWithType:ProductTypeB];
        [productB operation];
        
        
        // 使用工厂A创建产品A
        id<Factory> factoryA = [[ConcreteFactoryA alloc] init];
        id<Product> productAA = [factoryA createProduct];
        [productAA operation];
        
        // 使用工厂B创建产品B
        id<Factory> factoryB = [[ConcreteFactoryB alloc] init];
        id<Product> productBB = [factoryB createProduct];
        [productBB operation];
        
    }
    return 0;
}
