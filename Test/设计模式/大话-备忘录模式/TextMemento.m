#import "TextMemento.h"

@implementation TextMemento

- (instancetype)initWithContent:(NSString *)content {
    self = [super init];
    if (self) {
        _content = [content copy];
    }
    return self;
}

@end
