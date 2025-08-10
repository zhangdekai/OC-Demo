#import "Computer.h"

@implementation Computer

- (NSString *)description {
    return [NSString stringWithFormat:@"电脑配置：\nCPU：%@\n内存：%@\n硬盘：%@", self.cpu, self.memory, self.hardDisk];
}

@end
