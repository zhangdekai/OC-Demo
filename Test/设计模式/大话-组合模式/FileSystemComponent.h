#import <Foundation/Foundation.h>

// 最大允许的层级深度
static const NSUInteger MAX_DEPTH_LIMIT = 10;

@interface FileSystemComponent : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, weak) FileSystemComponent *parent; // 父节点，用于计算深度

- (instancetype)initWithName:(NSString *)name;

// 计算大小
- (NSUInteger)size;

// 显示文件/文件夹信息
- (void)displayWithIndent:(NSInteger)indent;

@end
