#import "Elephant.h"
#import "VisitorProtocol.h"

@implementation Elephant

- (instancetype)initWithName:(NSString *)name weight:(NSInteger)weight {
    self = [super init];
    if (self) {
        _name = name;
        _weight = weight;
    }
    return self;
}

// 接受访问者
- (void)accept:(id<VisitorProtocol>)visitor {
    [visitor visitElephant:self];
}

@end
