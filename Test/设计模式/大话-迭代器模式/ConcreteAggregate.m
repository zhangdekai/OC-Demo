#import "ConcreteAggregate.h"
#import "ConcreteIterator.h"

@implementation ConcreteAggregate {
    NSMutableArray *_items;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _items = [NSMutableArray array];
    }
    return self;
}

- (void)addObject:(id)object {
    [_items addObject:object];
}

- (id)objectAtIndex:(NSInteger)index {
    return _items[index];
}

- (NSInteger)count {
    return _items.count;
}

- (id<IteratorProtocol>)createIterator {
    return [[ConcreteIterator alloc] initWithAggregate:self];
}

@end
