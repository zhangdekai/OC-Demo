#import "ConcreteFactoryA.h"
#import "ConcreteProductA.h"

@implementation ConcreteFactoryA
- (id<Product>)createProduct {
    return [[ConcreteProductA alloc] init];
}
@end
