// TextFile.m
#import "TextFile.h"

@implementation TextFile

- (instancetype)initWithName:(NSString *)name 
                        size:(NSInteger)size 
                     content:(NSString *)content {
    self = [super init];
    if (self) {
        _name = [name copy];
        _size = size;
        _content = [content copy];
    }
    return self;
}

// 接受访问者
- (void)accept:(id<VisitorFileProtocol>)visitor {
    [visitor visitTextFile:self];
}

@end
