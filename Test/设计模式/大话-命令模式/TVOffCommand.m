#import "TVOffCommand.h"

@interface TVOffCommand ()

@property (nonatomic, strong) FamilyTV *tv;

@end

@implementation TVOffCommand

- (instancetype)initWithTV:(FamilyTV *)tv {
    self = [super init];
    if (self) {
        _tv = tv;
    }
    return self;
}

- (void)execute {
    [self.tv turnOff];
}

- (void)undo {
    [self.tv turnOn];
}

@end
