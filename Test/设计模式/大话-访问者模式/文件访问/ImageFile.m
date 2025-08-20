// ImageFile.m
#import "ImageFile.h"

@implementation ImageFile

- (instancetype)initWithName:(NSString *)name 
                        size:(NSInteger)size 
                  resolution:(NSString *)resolution {
    self = [super init];
    if (self) {
        _name = [name copy];
        _size = size;
        _resolution = [resolution copy];
    }
    return self;
}

// 接受访问者
- (void)accept:(id<VisitorFileProtocol>)visitor {
    [visitor visitImageFile:self];
}

@end
