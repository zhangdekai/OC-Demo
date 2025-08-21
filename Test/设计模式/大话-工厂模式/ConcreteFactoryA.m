#import "ConcreteFactoryA.h"
#import "ConcreteProductA.h"

@implementation ConcreteFactoryA
- (id<ProductFactoryProtocol>)createProduct {
    return [[ConcreteProductA alloc] init];
}
@end
