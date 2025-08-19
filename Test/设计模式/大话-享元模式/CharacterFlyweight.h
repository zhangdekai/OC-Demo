#import <Foundation/Foundation.h>

// 抽象享元类：定义字符的接口
@interface CharacterFlyweight : NSObject

@property (nonatomic, copy, readonly) NSString *symbol; // 字符符号(内部状态)
@property (nonatomic, copy, readonly) NSString *font;   // 字体(内部状态)
@property (nonatomic, assign, readonly) NSInteger size; // 大小(内部状态)

- (instancetype)initWithSymbol:(NSString *)symbol font:(NSString *)font size:(NSInteger)size;

// 显示字符，需要传入外部状态(位置)
- (void)displayAtX:(NSInteger)x y:(NSInteger)y;


/// 2. 外部状态的线程安全处理
/// 外部状态由客户端传入，可能在多线程中被并发修改，导致享元对象使用时状态不一致。
/// 解决原则是：外部状态应设计为不可变（Immutable），或通过复制隔离线程间的状态。
/// 使用不可变对象存储外部状态：例如用 NSString、NSNumber、NSValue
/// 等不可变类型传递外部状态（如位置、颜色）。
- (void)displayWithState:(NSDictionary<NSString *, id> *)state;


@end
