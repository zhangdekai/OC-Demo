#import <Foundation/Foundation.h>
#import "AnimalProtocol.h"

@interface Elephant : NSObject <AnimalProtocol>

@property (nonatomic, assign) NSInteger weight;
@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name weight:(NSInteger)weight;
@end
