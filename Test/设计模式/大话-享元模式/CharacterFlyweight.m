#import "CharacterFlyweight.h"

@implementation CharacterFlyweight

- (instancetype)initWithSymbol:(NSString *)symbol font:(NSString *)font size:(NSInteger)size {
    self = [super init];
    if (self) {
        _symbol = symbol;
        _font = font;
        _size = size;
    }
    return self;
}

- (void)displayAtX:(NSInteger)x y:(NSInteger)y {
    NSLog(@"显示字符 '%@' (字体: %@, 大小: %ld) 在位置 (%ld, %ld)", 
          self.symbol, self.font, (long)self.size, (long)x, (long)y);
}

// 享元对象的方法接收 不可变的外部状态
- (void)displayWithState:(NSDictionary<NSString *, id> *)state {
    // state 为不可变字典，避免被外部线程修改
    NSNumber *x = state[@"x"];
    NSNumber *y = state[@"y"];
    NSLog(@"显示在 (%@, %@)", x, y);
}

- (void)testDisplay{

    // 1. 客户端传递不可变状态
    NSDictionary *state = @{@"x": @10, @"y": @20}; // 不可变字典
    [self displayWithState:state];
    
    
    // 2. 线程内复制外部状态：若外部状态必须可变，在传递给享元对象前复制一份，避免线程间共享。
    // 客户端传递前复制状态（深拷贝）
    NSMutableDictionary *mutableState = [NSMutableDictionary dictionary];
    mutableState[@"x"] = @10;
    // 传递不可变副本给享元
    [self displayWithState:[mutableState copy]];
    
}

@end
