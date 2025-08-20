#import "Zoo.h"

@implementation Zoo {
    NSMutableArray<id<AnimalProtocol>> *_animals;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _animals = [NSMutableArray array];
    }
    return self;
}

- (void)addAnimal:(id<AnimalProtocol>)animal {
    [_animals addObject:animal];
}

- (void)accept:(id<VisitorProtocol>)visitor {
    for (id<AnimalProtocol> animal in _animals) {
        [animal accept:visitor];
    }
}

@end
