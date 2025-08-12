#import "File.h"

@implementation File

- (instancetype)initWithName:(NSString *)name size:(NSUInteger)size {
    if (self = [super initWithName:name]) {
        _fileSize = size;
    }
    return self;
}

- (NSUInteger)size {
    return self.fileSize;
}

- (void)displayWithIndent:(NSInteger)indent {
    NSString *indentStr = [@"" stringByPaddingToLength:indent withString:@" " startingAtIndex:0];
    NSLog(@"%@文件: %@ (%ldKB)", indentStr, self.name, (long)self.fileSize);
}

@end
