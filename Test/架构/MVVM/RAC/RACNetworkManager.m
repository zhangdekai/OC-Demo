#import "RACNetworkManager.h"
#import "RACUserModel.h"

@implementation RACNetworkManager

+ (instancetype)sharedManager {
    static RACNetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

/// 模拟获取用户列表网络请求
- (void)getUserListWithSuccess:(RACSuccessBlock)success failure:(RACFailureBlock)failure {
    // 模拟网络延迟1秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        // 模拟5条用户数据
        NSArray *mockUsers = @[
            [[RACUserModel alloc] initWithDict:@{@"name":@"张三", @"age":@25, @"address":@"北京市海淀区", @"hobbies":@[@"篮球", @"编程", @"旅行"]}],
            [[RACUserModel alloc] initWithDict:@{@"name":@"李四", @"age":@30, @"address":@"上海市静安区", @"hobbies":@[@"足球", @"唱歌", @"摄影"]}],
            [[RACUserModel alloc] initWithDict:@{@"name":@"王五", @"age":@22, @"address":@"广州市海珠区", @"hobbies":@[@"游泳", @"画画", @"烹饪"]}],
            [[RACUserModel alloc] initWithDict:@{@"name":@"赵六", @"age":@35, @"address":@"深圳市福田区", @"hobbies":@[@"跑步", @"阅读", @"音乐"]}],
            [[RACUserModel alloc] initWithDict:@{@"name":@"钱七", @"age":@28, @"address":@"杭州市西湖区", @"hobbies":@[@"摄影", @"旅行", @"美食"]}]
        ];
        
        // 回到主线程回调
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success(mockUsers);
            }
        });
    });
}

/// 模拟添加用户网络请求
- (void)addNewUser:(RACUserModel *)user success:(RACSuccessBlock)success failure:(RACFailureBlock)failure {
    // 模拟网络延迟1秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        // 模拟添加成功，返回添加的用户
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success(user);
            }
        });
    });
}

@end
