#import "MVVMUserModel.h"

@implementation MVVMUserModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _userId = dict[@"userId"] ?: [NSString stringWithFormat:@"%ld", arc4random() % 10000];
        _name = dict[@"name"] ?: @"未知用户";
        _age = [dict[@"age"] integerValue] ?: 18;
        _address = dict[@"address"] ?: @"未知地址";
        _hobbies = dict[@"hobbies"] ?: @[@"阅读", @"运动"];
    }
    return self;
}

/// 生成模拟用户（随机数据，用于点击"添加"时使用）
+ (instancetype)mockUser {
    // 随机姓名库
    NSArray *names = @[@"张三", @"李四", @"王五", @"赵六", @"钱七", @"孙八", @"周九", @"吴十"];
    // 随机地址库
    NSArray *addresses = @[@"北京市朝阳区", @"上海市浦东新区", @"广州市天河区", @"深圳市南山区", 
                          @"杭州市西湖区", @"南京市玄武区", @"成都市锦江区"];
    // 随机爱好库
    NSArray *allHobbies = @[@"篮球", @"足球", @"游泳", @"唱歌", @"画画", @"编程", 
                           @"摄影", @"旅行", @"阅读", @"跑步"];
    // 随机选3个爱好
    NSMutableArray *randomHobbies = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        NSString *hobby = allHobbies[arc4random() % allHobbies.count];
        if (![randomHobbies containsObject:hobby]) {
            [randomHobbies addObject:hobby];
        }
    }
    
    return [[self alloc] initWithDict:@{
        @"name": names[arc4random() % names.count],
        @"age": @(18 + arc4random() % 30), // 18-48岁
        @"address": addresses[arc4random() % addresses.count],
        @"hobbies": randomHobbies
    }];
}

@end
