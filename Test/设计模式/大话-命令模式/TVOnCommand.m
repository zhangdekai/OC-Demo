#import "TVOnCommand.h"

@interface TVOnCommand ()

@property (nonatomic, strong) FamilyTV *tv;

@end

@implementation TVOnCommand

- (instancetype)initWithTV:(FamilyTV *)tv {
    self = [super init];
    if (self) {
        _tv = tv;
    }
    return self;
}

- (void)execute {
    [self.tv turnOn];
}

- (void)undo {
    [self.tv turnOff];
}

@end
