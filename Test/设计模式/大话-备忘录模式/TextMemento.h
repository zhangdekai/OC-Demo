#import <Foundation/Foundation.h>

@interface TextMemento : NSObject

// 保存的文本内容（仅允许发起人访问）
@property (nonatomic, copy, readonly) NSString *content;

// 初始化方法
- (instancetype)initWithContent:(NSString *)content;

@end
