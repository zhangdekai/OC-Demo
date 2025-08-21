#import "ConcreteFactories.h"
#import "ConcreteProducts.h"

@implementation AppleFactory

- (id<PhoneProtocol>)createPhone {
    return [[IPhone alloc] init];
}

- (id<ComputerProtocol>)createComputer {
    return [[Mac alloc] init];
}

@end

@implementation HuaweiFactory

- (id<PhoneProtocol>)createPhone {
    return [[HuaweiPhone alloc] init];
}

- (id<ComputerProtocol>)createComputer {
    return [[HuaweiComputer alloc] init];
}

@end
