#import <Foundation/Foundation.h>
#import "BuilderProtocol.h"

@interface Director : NSObject

// 指挥建造者构建电脑
- (void)constructWithBuilder:(id<BuilderProtocol>)builder;

@end
