#import <Foundation/Foundation.h>
#import "ConcreteAggregate.h"
#import "IteratorProtocol.h"

int testIteratorPatternMain(void) {
    @autoreleasepool {
        // 创建集合并添加元素
        ConcreteAggregate *aggregate = [[ConcreteAggregate alloc] init];
        [aggregate addObject:@"元素1"];
        [aggregate addObject:@"元素2"];
        [aggregate addObject:@"元素3"];
        [aggregate addObject:@"元素4"];
        
        // 获取迭代器
        id<IteratorProtocol> iterator = [aggregate createIterator];
        
        // 使用迭代器遍历集合
        while ([iterator hasNext]) {
            id item = [iterator next];
            NSLog(@"遍历元素: %@", item);
        }
    }
    return 0;
}
