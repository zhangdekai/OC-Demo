#import "HistoryManager.h"

@implementation HistoryManager {
    NSMutableArray<TextMemento *> *_mementos;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _mementos = [NSMutableArray array];
    }
    return self;
}

- (void)saveMemento:(TextMemento *)memento {
    [_mementos addObject:memento];
}

- (TextMemento *)getLastMemento {
    if (_mementos.count == 0) {
        return nil;
    }
    
    TextMemento *lastMemento = _mementos.lastObject;
    [_mementos removeLastObject];
    return lastMemento;
}

@end
