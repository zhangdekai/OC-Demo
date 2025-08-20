// InfoVisitor.m
#import "InfoVisitor.h"
#import "TextFile.h"
#import "ImageFile.h"

@implementation InfoVisitor

// 访问文本文件
- (void)visitTextFile:(TextFile *)textFile {
    NSLog(@"文本文件信息:");
    NSLog(@"名称: %@", textFile.name);
    NSLog(@"大小: %ldKB", (long)textFile.size);
    
    // 内容预览（限制长度）
    NSString *preview = textFile.content;
    if (preview.length > 30) {
        preview = [preview substringToIndex:30];
        preview = [preview stringByAppendingString:@"..."];
    }
    NSLog(@"内容预览: %@", preview);
    NSLog(@"---------------------");
}

// 访问图片文件
- (void)visitImageFile:(ImageFile *)imageFile {
    NSLog(@"图片文件信息:");
    NSLog(@"名称: %@", imageFile.name);
    NSLog(@"大小: %ldKB", (long)imageFile.size);
    NSLog(@"分辨率: %@", imageFile.resolution);
    NSLog(@"---------------------");
}

@end
