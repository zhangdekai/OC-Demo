#import <Foundation/Foundation.h>
#import "CommandProtocol.h"
#import "Light.h"

// 具体命令：关闭电灯
@interface LightOffCommand : NSObject <CommandProtocol>

- (instancetype)initWithLight:(Light *)light;

@end
