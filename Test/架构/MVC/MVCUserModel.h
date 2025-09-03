#import <Foundation/Foundation.h>

@interface MVCUserModel : NSObject

// 用户属性
@property (nonatomic, copy) NSString *userId;    // 用户ID
@property (nonatomic, copy) NSString *name;      // 姓名
@property (nonatomic, assign) NSInteger age;     // 年龄
@property (nonatomic, copy) NSString *address;   // 地址
@property (nonatomic, copy) NSString *hobby;     // 爱好

// 从字典初始化模型
- (instancetype)initWithDictionary:(NSDictionary *)dict;

// 转换为字典
- (NSDictionary *)toDictionary;

@end
    