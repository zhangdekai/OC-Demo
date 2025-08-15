#import <Foundation/Foundation.h>
#import "Command.h"
#import "Light.h"

// 具体命令：打开电灯
@interface LightOnCommand : NSObject <Command>

- (instancetype)initWithLight:(Light *)light;

@end
