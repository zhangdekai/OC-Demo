#import <Foundation/Foundation.h>
#import "CommandProtocol.h"
#import "Light.h"

// 具体命令：打开电灯
@interface LightOnCommand : NSObject <CommandProtocol>

- (instancetype)initWithLight:(Light *)light;

@end
