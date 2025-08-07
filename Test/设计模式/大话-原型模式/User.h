#import <Foundation/Foundation.h>

@interface ProtoTypeUser : NSObject <NSCopying>

@property (nonatomic, copy) NSString *name;  // 姓名
@property (nonatomic, assign) NSInteger age; // 年龄

// 初始化方法
- (instancetype)initWithName:(NSString *)name age:(NSInteger)age;

@end
