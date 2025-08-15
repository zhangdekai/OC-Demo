#import "LightOnCommand.h"

@interface LightOnCommand ()

@property (nonatomic, strong) Light *light;

@end

@implementation LightOnCommand

- (instancetype)initWithLight:(Light *)light {
    self = [super init];
    if (self) {
        _light = light;
    }
    return self;
}

- (void)execute {
    [self.light turnOn];
}

- (void)undo {
    [self.light turnOff];
}

@end
