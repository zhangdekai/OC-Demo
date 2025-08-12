#import "Folder.h"
#import "FileSystemComponent.h"

@interface Folder ()
@property (nonatomic, strong) NSMutableArray<FileSystemComponent *> *children;
@end

@implementation Folder

- (instancetype)initWithName:(NSString *)name {
    if (self = [super initWithName:name]) {
        _children = [NSMutableArray array];
    }
    return self;
}

// 添加子组件，带深度检查
- (BOOL)addComponent:(FileSystemComponent *)component {
    // 检查添加后是否超过最大深度限制
    NSUInteger newDepth = [self depth] + 1;
    if (newDepth > MAX_DEPTH_LIMIT) {
        NSLog(@"警告: 无法添加 %@ 到 %@，会超过最大深度限制 %ld", 
              component.name, self.name, (long)MAX_DEPTH_LIMIT);
        return NO;
    }
    
    component.parent = self;
    [self.children addObject:component];
    return YES;
}

- (BOOL)removeComponent:(FileSystemComponent *)component {
    if ([self.children containsObject:component]) {
        [self.children removeObject:component];
        component.parent = nil;
        return YES;
    }
    return NO;
}

// 使用迭代方式计算大小，避免递归深度问题
- (NSUInteger)size {
    NSUInteger totalSize = 0;
    NSMutableArray<FileSystemComponent *> *stack = [NSMutableArray array];
    
    // 将所有子节点加入栈中
    for (FileSystemComponent *child in self.children) {
        [stack addObject:child];
    }
    
    // 迭代处理所有节点
    while (stack.count > 0) {
        FileSystemComponent *current = [stack lastObject];
        [stack removeLastObject];
        
        totalSize += current.size;
        
        // 如果是文件夹，将其子节点加入栈中继续处理
        if ([current isKindOfClass:[Folder class]]) {
            Folder *subFolder = (Folder *)current;
            // 逆序添加，保持与递归处理相同的顺序
            for (NSInteger i = subFolder.children.count - 1; i >= 0; i--) {
                [stack addObject:subFolder.children[i]];
            }
        }
    }
    
    return totalSize;
}

// 使用迭代方式显示所有内容，避免递归深度问题
- (void)displayWithIndent:(NSInteger)indent {
    
    NSString *indentStr = [@"" stringByPaddingToLength:indent withString:@" " startingAtIndex:0];
    
    NSLog(@"%@文件夹: %@ (%ldKB)", indentStr, self.name, (long)[self size]);
    
    NSMutableArray *stack = [NSMutableArray array];
    
    // 入栈时同时记录缩进级别
    for (FileSystemComponent *child in self.children) {
        [stack addObject:@[child, @(indent + 4)]];
    }
    
    while (stack.count > 0) {
        NSArray *item = [stack lastObject];
        [stack removeLastObject];
        
        FileSystemComponent *current = item[0];
        NSInteger currentIndent = [item[1] integerValue];
        
        [current displayWithIndent:currentIndent];
        
        // 如果是文件夹，将其子节点入栈
        if ([current isKindOfClass:[Folder class]]) {
            Folder *subFolder = (Folder *)current;
            // 逆序添加，保持正确的显示顺序
            for (NSInteger i = subFolder.children.count - 1; i >= 0; i--) {
                [stack addObject:@[subFolder.children[i], @(currentIndent + 4)]];
            }
        }
    }
}

// 计算当前节点的深度
- (NSUInteger)depth {
    NSUInteger depth = 0;
    FileSystemComponent *currentParent = self.parent;
    while (currentParent) {
        depth++;
        currentParent = currentParent.parent;
    }
    return depth;
}

- (NSInteger)oldWaySize {
    NSInteger totalSize = 0;
    // 递归计算总大小
    for (FileSystemComponent *component in self.children) {
        totalSize += [component size];
    }
    return totalSize;
}

@end
