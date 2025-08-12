#import <Foundation/Foundation.h>

@protocol IteratorProtocol <NSObject>

// 判断是否还有下一个元素
- (BOOL)hasNext;

// 获取下一个元素
- (id)next;

@end
