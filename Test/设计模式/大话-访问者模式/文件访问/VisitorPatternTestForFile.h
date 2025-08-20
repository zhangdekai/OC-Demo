// main.m
#import <Foundation/Foundation.h>
#import "FileManager.h"
#import "TextFile.h"
#import "ImageFile.h"
#import "SizeVisitor.h"
#import "InfoVisitor.h"

int testVisitorPatternFileMain(void) {
    @autoreleasepool {
        // 创建文件管理器
        FileManager *fileManager = [[FileManager alloc] init];
        
        // 添加文件
        [fileManager addFile:[[TextFile alloc] initWithName:@"readme.txt"
                                                      size:10
                                                   content:@"这是一个示例文本文件，用于演示访问者模式的用法和原理"]];
        [fileManager addFile:[[ImageFile alloc] initWithName:@"photo.jpg"
                                                       size:2048
                                                 resolution:@"1920x1080"]];
        [fileManager addFile:[[TextFile alloc] initWithName:@"notes.txt"
                                                      size:5
                                                   content:@"这是一些简单的笔记内容"]];
        [fileManager addFile:[[ImageFile alloc] initWithName:@"logo.png"
                                                       size:128
                                                 resolution:@"512x512"]];
        
        // 使用大小统计访问者
        NSLog(@"===== 统计文件大小 =====");
        SizeVisitor *sizeVisitor = [[SizeVisitor alloc] init];
        [fileManager accept:sizeVisitor];
        NSLog(@"总大小: %ldKB", (long)sizeVisitor.totalSize);
        
        // 使用信息打印访问者
        NSLog(@"\n===== 查看文件信息 =====");
        InfoVisitor *infoVisitor = [[InfoVisitor alloc] init];
        [fileManager accept:infoVisitor];
    }
    return 0;
}
