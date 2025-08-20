#import <Foundation/Foundation.h>

@protocol VisitorProtocol; // 前向声明

// 动物元素协议
@protocol AnimalProtocol <NSObject>

- (void)accept:(id<VisitorProtocol>)visitor;

@end
