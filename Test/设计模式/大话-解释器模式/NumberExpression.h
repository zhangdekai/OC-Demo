#import <Foundation/Foundation.h>
#import "ExpressionProtocol.h"

// 数字表达式（终结符表达式）
@interface NumberExpression : NSObject <ExpressionProtocol>

- (instancetype)initWithNumber:(NSInteger)number;

@end
