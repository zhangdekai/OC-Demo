#import <Foundation/Foundation.h>

// 抽象组件：所有饮料的基类，定义了基本接口
@interface BeverageBase : NSObject

// 返回饮料描述
- (NSString *)description;

// 返回饮料价格
- (double)cost;

@end
