#import <Foundation/Foundation.h>

@class Lion;
@class Elephant;
@class Monkey;

// 访问者协议
@protocol VisitorProtocol <NSObject>

- (void)visitLion:(Lion *)lion;
- (void)visitElephant:(Elephant *)elephant;
- (void)visitMonkey:(Monkey *)monkey;

@end
