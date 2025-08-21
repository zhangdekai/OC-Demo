#import "BeverageBase.h"

// 抽象装饰器：所有配料的基类
// 必须继承自Beverage以保证接口一致性
@interface CondimentDecorator : BeverageBase

// 被装饰的饮料对象
@property (nonatomic, strong) BeverageBase *beverage;

// 初始化方法，需要传入被装饰的饮料
- (instancetype)initWithBeverage:(BeverageBase *)beverage;

@end
