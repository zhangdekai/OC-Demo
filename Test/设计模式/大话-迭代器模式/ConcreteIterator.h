#import <Foundation/Foundation.h>
#import "IteratorProtocol.h"

@class ConcreteAggregate;

@interface ConcreteIterator : NSObject <IteratorProtocol>

- (instancetype)initWithAggregate:(ConcreteAggregate *)aggregate;

@end
