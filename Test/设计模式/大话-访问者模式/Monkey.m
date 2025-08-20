#import "Monkey.h"
#import "VisitorProtocol.h"

@implementation Monkey

- (instancetype)initWithName:(NSString *)name height:(NSInteger)height {
    self = [super init];
    if (self) {
        _name = name;
        _height = height;
    }
    return self;
}

// 接受访问者
- (void)accept:(id<VisitorProtocol>)visitor {
    [visitor visitMonkey:self];
}

@end
