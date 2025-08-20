#import <Foundation/Foundation.h>
#import "AnimalProtocol.h"

@interface Monkey : NSObject <AnimalProtocol>
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name height:(NSInteger)height;
@end
