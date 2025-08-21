#import "SimpleFactory.h"
#import "ConcreteProductA.h"
#import "ConcreteProductB.h"

@implementation SimpleFactory

+ (id<ProductFactoryProtocol>)createProductWithType:(ProductType)type {
    switch (type) {
        case ProductTypeA:
            return [[ConcreteProductA alloc] init];
        case ProductTypeB:
            return [[ConcreteProductB alloc] init];
        default:
            return nil;
    }
}
@end
