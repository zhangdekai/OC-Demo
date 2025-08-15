#import <Foundation/Foundation.h>

// 命令接口协议
@protocol Command <NSObject>

- (void)execute;
- (void)undo;

@end
