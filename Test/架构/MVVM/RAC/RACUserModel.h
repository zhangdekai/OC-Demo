#import <Foundation/Foundation.h>

@interface RACUserModel : NSObject

/// 用户ID
@property (nonatomic, copy) NSString *userId;
/// 姓名
@property (nonatomic, copy) NSString *name;
/// 年龄
@property (nonatomic, assign) NSInteger age;
/// 地址
@property (nonatomic, copy) NSString *address;
/// 爱好
@property (nonatomic, strong) NSArray<NSString *> *hobbies;

/// 从字典初始化
- (instancetype)initWithDict:(NSDictionary *)dict;
/// 生成模拟用户
+ (instancetype)mockUser;

@end
