#import "LightOffCommand.h"

@interface LightOffCommand ()

@property (nonatomic, strong) Light *light;

@end

@implementation LightOffCommand

- (instancetype)initWithLight:(Light *)light {
    self = [super init];
    if (self) {
        _light = light;
    }
    return self;
}

- (void)execute {
    [self.light turnOff];
}

- (void)undo {
    [self.light turnOn];
}

@end
