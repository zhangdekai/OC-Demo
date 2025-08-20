#import <Foundation/Foundation.h>
#import "AnimalProtocol.h"

@interface Zoo : NSObject

- (void)addAnimal:(id<AnimalProtocol>)animal;

- (void)accept:(id<VisitorProtocol>)visitor;

@end
