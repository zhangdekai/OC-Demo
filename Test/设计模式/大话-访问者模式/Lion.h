#import <Foundation/Foundation.h>
#import "AnimalProtocol.h"

@interface Lion : NSObject <AnimalProtocol>

@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age;
@end
