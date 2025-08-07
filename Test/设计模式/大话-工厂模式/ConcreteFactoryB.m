#import "ConcreteFactoryB.h"
#import "ConcreteProductB.h"

@implementation ConcreteFactoryB
- (id<Product>)createProduct {
    return [[ConcreteProductB alloc] init];
}
@end
