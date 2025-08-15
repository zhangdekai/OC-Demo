#import <Foundation/Foundation.h>
#import "Command.h"

// 调用者：遥控器
@interface RemoteControl : NSObject

- (void)setCommand:(id<Command>)command;
- (void)pressButton;
- (void)pressUndoButton;

@end
