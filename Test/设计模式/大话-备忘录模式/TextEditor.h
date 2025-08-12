#import <Foundation/Foundation.h>
#import "TextMemento.h"

@interface TextEditor : NSObject

// 当前文本内容
@property (nonatomic, copy) NSString *content;

// 创建备忘录
- (TextMemento *)createMemento;

// 从备忘录恢复
- (void)restoreFromMemento:(TextMemento *)memento;

@end
