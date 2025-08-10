#import "MacBookBuilder.h"

@interface MacBookBuilder ()

@property (nonatomic, strong) Computer *computer;

@end

@implementation MacBookBuilder

- (instancetype)init {
    self = [super init];
    if (self) {
        self.computer = [[Computer alloc] init];
    }
    return self;
}

- (void)buildCPU {
    self.computer.cpu = @"Apple M2 Pro";
}

- (void)buildMemory {
    self.computer.memory = @"16GB 统一内存";
}

- (void)buildHardDisk {
    self.computer.hardDisk = @"512GB SSD";
}

- (Computer *)getComputer {
    return self.computer;
}

@end
