#import <Foundation/Foundation.h>
#import "File.h"
#import "Folder.h"

int testCompositePatternMain(void) {
    @autoreleasepool {
        // 创建文件
        File *file1 = [[File alloc] initWithName:@"文档1.txt" size:1024];
        File *file2 = [[File alloc] initWithName:@"图片1.png" size:2048];
        File *file3 = [[File alloc] initWithName:@"数据.csv" size:512];
        
        // 创建子文件夹
        Folder *subFolder = [[Folder alloc] initWithName:@"子文件夹"];
        [subFolder addComponent:file3];
        
        // 创建主文件夹
        Folder *mainFolder = [[Folder alloc] initWithName:@"主文件夹"];
        [mainFolder addComponent:file1];
        [mainFolder addComponent:file2];
        [mainFolder addComponent:subFolder];
        
        // 测试深度限制 - 创建超过深度限制的层级
        Folder *deepFolder = mainFolder;
        for (int i = 1; i <= 15; i++) {
            Folder *newFolder = [[Folder alloc] initWithName:[NSString stringWithFormat:@"深层文件夹%d", i]];
            BOOL success = [deepFolder addComponent:newFolder];
            if (success) {
                deepFolder = newFolder;
            } else {
                NSLog(@"在创建第%d层文件夹时失败", i);
                break;
            }
        }
        
        // 展示文件系统结构
        NSLog(@"文件系统结构:");
        [mainFolder displayWithIndent:0];
        
        // 计算并展示总大小
        NSLog(@"总大小: %ldKB", (long)[mainFolder size]);
    }
    return 0;
}
