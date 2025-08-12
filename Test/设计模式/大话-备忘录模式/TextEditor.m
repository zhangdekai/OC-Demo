#import "TextEditor.h"

@implementation TextEditor

- (TextMemento *)createMemento {
    // 创建备忘录并保存当前状态
    return [[TextMemento alloc] initWithContent:self.content];
}

- (void)restoreFromMemento:(TextMemento *)memento {
    // 从备忘录恢复状态
    self.content = memento.content;
}

@end
