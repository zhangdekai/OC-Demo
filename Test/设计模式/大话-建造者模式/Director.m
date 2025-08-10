#import "Director.h"

@implementation Director

- (void)constructWithBuilder:(id<BuilderProtocol>)builder {
    // 按固定流程构建：CPU → 内存 → 硬盘
    [builder buildCPU];
    [builder buildMemory];
    [builder buildHardDisk];
}

@end
