#import <Foundation/Foundation.h>

// 抽象处理者（Abstract Handler）
@interface AbstractApprover : NSObject

// 下一个
@property (nonatomic, strong) AbstractApprover *nextApprover;
@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

// 子类（具体处理者（Concrete Handler））去实现
- (void)approve:(CGFloat)amount;

@end
