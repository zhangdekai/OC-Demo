#import <Foundation/Foundation.h>

@interface Computer : NSObject

@property (nonatomic, copy) NSString *cpu;    // 处理器
@property (nonatomic, copy) NSString *memory; // 内存
@property (nonatomic, copy) NSString *hardDisk; // 硬盘

// 描述电脑配置
- (NSString *)description;

@end
