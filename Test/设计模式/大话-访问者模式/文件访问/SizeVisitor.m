// SizeVisitor.m
#import "SizeVisitor.h"
#import "TextFile.h"
#import "ImageFile.h"

@implementation SizeVisitor {
    NSInteger _totalSize;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _totalSize = 0;
    }
    return self;
}

- (NSInteger)totalSize {
    return _totalSize;
}

// 访问文本文件
- (void)visitTextFile:(TextFile *)textFile {
    _totalSize += textFile.size;
    NSLog(@"统计文本文件: %@ (%ldKB)", textFile.name, (long)textFile.size);
}

// 访问图片文件
- (void)visitImageFile:(ImageFile *)imageFile {
    _totalSize += imageFile.size;
    NSLog(@"统计图片文件: %@ (%ldKB)", imageFile.name, (long)imageFile.size);
}

@end
