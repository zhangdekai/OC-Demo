#import <Foundation/Foundation.h>
#import "Computer.h"

@protocol BuilderProtocol <NSObject>

// 构建CPU
- (void)buildCPU;
// 构建内存
- (void)buildMemory;
// 构建硬盘
- (void)buildHardDisk;
// 获取构建好的电脑
- (Computer *)getComputer;

@end
