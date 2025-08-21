#import <Foundation/Foundation.h>
#import "SimpleFactory.h"
#import "ConcreteFactoryA.h"
#import "ConcreteFactoryB.h"
#import "ProductFactoryProtocol.h"

int testFactoryMethodPatternMain(void) {
    @autoreleasepool {
        
        NSLog(@"简单工厂模式，，，，，\n");
        
        // 使用简单工厂创建产品A
        id<ProductFactoryProtocol> productA = [SimpleFactory createProductWithType:ProductTypeA];
        [productA operation];
        
        // 使用简单工厂创建产品B
        id<ProductFactoryProtocol> productB = [SimpleFactory createProductWithType:ProductTypeB];
        [productB operation];
        
        
        NSLog(@"工厂方法模式，，，，，\n");
        // 使用工厂A创建产品A
        id<FactoryProtocol> factoryA = [[ConcreteFactoryA alloc] init];
        id<ProductFactoryProtocol> productAA = [factoryA createProduct];
        [productAA operation];
        
        // 使用工厂B创建产品B
        id<FactoryProtocol> factoryB = [[ConcreteFactoryB alloc] init];
        id<ProductFactoryProtocol> productBB = [factoryB createProduct];
        [productBB operation];
        
    }
    return 0;
}
