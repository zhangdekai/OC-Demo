#import <Foundation/Foundation.h>
#import "CommandProtocol.h"

// 调用者：遥控器
@interface RemoteControl : NSObject

- (void)setCommand:(id<CommandProtocol>)command;
- (void)pressButton;
- (void)pressUndoButton;

@end
