#import "MMVMKVOUserModel.h"

@implementation MMVMKVOUserModel

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

+ (instancetype)mockUser {
    NSArray *names = @[@"张三", @"李四", @"王五", @"赵六", @"钱七", @"孙八"];
    NSArray *addresses = @[@"北京市朝阳区", @"上海市浦东新区", @"广州市天河区", @"深圳市南山区", @"杭州市西湖区"];
    NSArray *allHobbies = @[@"篮球", @"足球", @"游泳", @"唱歌", @"画画", @"编程", @"摄影", @"旅行"];
    
    NSMutableArray *randomHobbies = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        NSString *hobby = allHobbies[arc4random() % allHobbies.count];
        if (![randomHobbies containsObject:hobby]) {
            [randomHobbies addObject:hobby];
        }
    }
    
    return [[self alloc] initWithDict:@{
        @"name": names[arc4random() % names.count],
        @"age": @(18 + arc4random() % 30),
        @"address": addresses[arc4random() % addresses.count],
        @"hobbies": randomHobbies
    }];
}

@end
    