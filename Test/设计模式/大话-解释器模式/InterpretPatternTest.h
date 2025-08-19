#import <Foundation/Foundation.h>
#import "InterpretContext.h"
#import "NumberExpression.h"
#import "AddExpression.h"
#import "SubtractExpression.h"

int testInterpretPatternMain(void) {
    @autoreleasepool {
        // 创建上下文
        InterpretContext *context = [[InterpretContext alloc] init];
        
        // 构建表达式: 10 + 20 - 5
        // 首先创建数字表达式（终结符）
        id<ExpressionProtocol> ten = [[NumberExpression alloc] initWithNumber:10];
        id<ExpressionProtocol> twenty = [[NumberExpression alloc] initWithNumber:20];
        id<ExpressionProtocol> five = [[NumberExpression alloc] initWithNumber:5];
        
        // 构建加法表达式: 10 + 20
        id<ExpressionProtocol> addExpr = [[AddExpression alloc] initWithLeftExpression:ten rightExpression:twenty];
        
        // 构建减法表达式: (10 + 20) - 5
        id<ExpressionProtocol> subtractExpr = [[SubtractExpression alloc] initWithLeftExpression:addExpr rightExpression:five];
        
        // 解释执行表达式
        NSInteger result = [subtractExpr interpret:context];
        NSLog(@"10 + 20 - 5 = %ld", (long)result);
        
        // 演示使用变量的情况
        [context setVariable:@"a" value:15];
        [context setVariable:@"b" value:7];
        
        // 构建表达式: a + (10 - b)
        id<ExpressionProtocol> aVar = [[NumberExpression alloc] initWithNumber:[context getVariable:@"a"]];
        id<ExpressionProtocol> bVar = [[NumberExpression alloc] initWithNumber:[context getVariable:@"b"]];
        
        id<ExpressionProtocol> tenExpr = [[NumberExpression alloc] initWithNumber:10];
        id<ExpressionProtocol> subtractExpr2 = [[SubtractExpression alloc] initWithLeftExpression:tenExpr rightExpression:bVar];
        id<ExpressionProtocol> addExpr2 = [[AddExpression alloc] initWithLeftExpression:aVar rightExpression:subtractExpr2];
        
        NSInteger result2 = [addExpr2 interpret:context];
        NSLog(@"a + (10 - b) = %ld (其中a=15, b=7)", (long)result2);
    }
    return 0;
}
