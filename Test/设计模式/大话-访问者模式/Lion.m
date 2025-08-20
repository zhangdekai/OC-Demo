#import "Lion.h"
#import "VisitorProtocol.h"

@implementation Lion

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age {
    self = [super init];
    if (self) {
        _name = name;
        _age = age;
    }
    return self;
}

// 接受访问者
- (void)accept:(id<VisitorProtocol>)visitor {
    [visitor visitLion:self];
}

@end
