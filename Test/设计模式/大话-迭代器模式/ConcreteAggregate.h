#import <Foundation/Foundation.h>
#import "AggregateProtocol.h"

@interface ConcreteAggregate : NSObject <AggregateProtocol>

// 添加元素
- (void)addObject:(id)object;

// 获取指定位置元素
- (id)objectAtIndex:(NSInteger)index;

// 获取元素数量
- (NSInteger)count;

@end
