#import "ConcreteIterator.h"
#import "ConcreteAggregate.h"

@implementation ConcreteIterator {
    ConcreteAggregate *_aggregate;
    NSInteger _index;
}

- (instancetype)initWithAggregate:(ConcreteAggregate *)aggregate {
    self = [super init];
    if (self) {
        _aggregate = aggregate;
        _index = 0;
    }
    return self;
}

- (BOOL)hasNext {
    return _index < [_aggregate count];
}

- (id)next {
    id result = nil;
    if ([self hasNext]) {
        result = [_aggregate objectAtIndex:_index];
        _index++;
    }
    return result;
}

@end
