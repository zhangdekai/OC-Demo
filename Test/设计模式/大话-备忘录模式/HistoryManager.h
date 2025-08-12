#import <Foundation/Foundation.h>
#import "TextMemento.h"

@interface HistoryManager : NSObject

// 保存备忘录
- (void)saveMemento:(TextMemento *)memento;

// 获取最近的备忘录
- (TextMemento *)getLastMemento;

@end
