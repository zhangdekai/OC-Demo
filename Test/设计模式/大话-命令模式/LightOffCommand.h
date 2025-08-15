#import <Foundation/Foundation.h>
#import "Command.h"
#import "Light.h"

// 具体命令：关闭电灯
@interface LightOffCommand : NSObject <Command>

- (instancetype)initWithLight:(Light *)light;

@end
