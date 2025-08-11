#import <Foundation/Foundation.h>
#import "NewsObserverProtocol.h"

@interface Newspaper : NSObject <NewsObserverProtocol>

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end
