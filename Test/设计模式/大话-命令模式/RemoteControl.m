#import "RemoteControl.h"

@interface RemoteControl ()

@property (nonatomic, strong) id<CommandProtocol> command;
@property (nonatomic, strong) id<CommandProtocol> lastCommand;

@end

@implementation RemoteControl

- (void)setCommand:(id<CommandProtocol>)command {
    self.command = command;
}

- (void)pressButton {
    [self.command execute];
    self.lastCommand = self.command;
}

- (void)pressUndoButton {
    if (self.lastCommand) {
        [self.lastCommand undo];
    } else {
        NSLog(@"没有可撤销的操作");
    }
}

@end
