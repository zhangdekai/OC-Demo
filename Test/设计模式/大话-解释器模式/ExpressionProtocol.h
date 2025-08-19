#import <Foundation/Foundation.h>

@class InterpretContext;

// 抽象表达式协议
@protocol ExpressionProtocol <NSObject>

- (NSInteger)interpret:(InterpretContext *)context;

@end
