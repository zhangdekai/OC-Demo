#import "MVVMNetworkManager.h"

@implementation MVVMNetworkManager

+ (instancetype)sharedManager {
    static MVVMNetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

/// 模拟GET请求：1秒后返回模拟用户列表
- (void)getUserListWithSuccess:(MVVMSuccessBlock)success failure:(MVVMFailureBlock)failure {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        // 模拟5条初始用户数据
        NSArray *mockUsers = @[
            [[MVVMUserModel alloc] initWithDict:@{@"name":@"张三", @"age":@25, @"address":@"北京市海淀区", @"hobbies":@[@"篮球", @"编程"]}],
            [[MVVMUserModel alloc] initWithDict:@{@"name":@"李四", @"age":@30, @"address":@"上海市静安区", @"hobbies":@[@"足球", @"唱歌"]}],
            [[MVVMUserModel alloc] initWithDict:@{@"name":@"王五", @"age":@22, @"address":@"广州市海珠区", @"hobbies":@[@"游泳", @"画画"]}],
            [[MVVMUserModel alloc] initWithDict:@{@"name":@"赵六", @"age":@35, @"address":@"深圳市福田区", @"hobbies":@[@"跑步", @"阅读"]}],
            [[MVVMUserModel alloc] initWithDict:@{@"name":@"钱七", @"age":@28, @"address":@"杭州市西湖区", @"hobbies":@[@"摄影", @"旅行"]}]
        ];
        
        // 回到主线程回调
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success(mockUsers);
            }
        });
    });
}

/// 模拟POST请求：1秒后返回成功
- (void)addNewUser:(MVVMUserModel *)user success:(MVVMSuccessBlock)success failure:(MVVMFailureBlock)failure {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        // 模拟接口返回成功（实际项目中会返回新增用户的完整信息）
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success(@{@"code":@200, @"message":@"添加成功", @"data":user});
            }
        });
    });
}

@end
