#import "FileSystemComponent.h"

@implementation FileSystemComponent

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        _name = [name copy];
    }
    return self;
}

- (NSUInteger)size {
    // 子类实现
    return 0;
}

- (void)displayWithIndent:(NSInteger)indent {
    // 子类实现
}

@end
