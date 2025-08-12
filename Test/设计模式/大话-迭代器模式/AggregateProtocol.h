#import <Foundation/Foundation.h>
#import "IteratorProtocol.h"

@protocol AggregateProtocol <NSObject>

// 创建迭代器
- (id<IteratorProtocol>)createIterator;

@end
