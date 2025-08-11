#import "ConcreteFactories.h"
#import "ConcreteProducts.h"

@implementation AppleFactory

- (id<Phone>)createPhone {
    return [[IPhone alloc] init];
}

- (id<Computer>)createComputer {
    return [[Mac alloc] init];
}

@end

@implementation HuaweiFactory

- (id<Phone>)createPhone {
    return [[HuaweiPhone alloc] init];
}

- (id<Computer>)createComputer {
    return [[HuaweiComputer alloc] init];
}

@end
