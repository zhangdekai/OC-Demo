#import <Foundation/Foundation.h>

@interface MVVMUserModel : NSObject
/// 用户ID
@property (nonatomic, copy) NSString *userId;
/// 姓名
@property (nonatomic, copy) NSString *name;
/// 年龄
@property (nonatomic, assign) NSInteger age;
/// 地址
@property (nonatomic, copy) NSString *address;
/// 爱好（数组）
@property (nonatomic, strong) NSArray<NSString *> *hobbies;

/// 从字典初始化模型
- (instancetype)initWithDict:(NSDictionary *)dict;
/// 生成模拟用户数据（用于添加功能）
+ (instancetype)mockUser;

@end
