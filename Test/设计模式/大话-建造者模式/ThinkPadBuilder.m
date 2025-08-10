#import "ThinkPadBuilder.h"

@interface ThinkPadBuilder ()

@property (nonatomic, strong) Computer *computer;

@end

@implementation ThinkPadBuilder

- (instancetype)init {
    self = [super init];
    if (self) {
        self.computer = [[Computer alloc] init];
    }
    return self;
}

- (void)buildCPU {
    self.computer.cpu = @"Intel i7-13700H";
}

- (void)buildMemory {
    self.computer.memory = @"32GB DDR5";
}

- (void)buildHardDisk {
    self.computer.hardDisk = @"1TB SSD";
}

- (Computer *)getComputer {
    return self.computer;
}

@end
