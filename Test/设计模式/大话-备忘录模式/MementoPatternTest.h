#import <Foundation/Foundation.h>
#import "TextEditor.h"
#import "HistoryManager.h"

int testMementoPatternMain(void) {
    @autoreleasepool {
        // 创建文本编辑器
        TextEditor *editor = [[TextEditor alloc] init];
        // 创建历史记录管理器
        HistoryManager *history = [[HistoryManager alloc] init];
        
        // 输入第一段文字
        editor.content = @"1: 第一段文字";
        NSLog(@"当前内容: %@", editor.content);
        // 保存状态
        [history saveMemento:[editor createMemento]];
        
        // 输入第二段文字
        editor.content = @"2: 第一段文字\n第二段文字";
        NSLog(@"当前内容: %@", editor.content);
        // 保存状态
        [history saveMemento:[editor createMemento]];
        
        // 输入第三段文字
        editor.content = @"3: 第一段文字\n第二段文字\n第三段文字";
        NSLog(@"当前内容: %@", editor.content);
        
        // 撤销操作
        [editor restoreFromMemento:[history getLastMemento]];
        NSLog(@"撤销后内容: %@", editor.content);
        
        // 再次撤销
        [editor restoreFromMemento:[history getLastMemento]];
        NSLog(@"再次撤销后内容: %@", editor.content);
    }
    return 0;
}
