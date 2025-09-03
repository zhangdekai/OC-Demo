#import "MMVMKVONetworkManager.h"

@implementation MMVMKVONetworkManager

+ (instancetype)sharedManager {
    static MMVMKVONetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)getUserListWithSuccess:(MMVMKVOSuccessBlock)success failure:(MMVMKVOFailureBlock)failure {
    // 模拟网络延迟1秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        NSArray *mockUsers = @[
            [[MMVMKVOUserModel alloc] initWithDict:@{@"name":@"张三", @"age":@25, @"address":@"北京市海淀区", @"hobbies":@[@"篮球", @"编程"]}],
            [[MMVMKVOUserModel alloc] initWithDict:@{@"name":@"李四", @"age":@30, @"address":@"上海市静安区", @"hobbies":@[@"足球", @"唱歌"]}],
            [[MMVMKVOUserModel alloc] initWithDict:@{@"name":@"王五", @"age":@22, @"address":@"广州市海珠区", @"hobbies":@[@"游泳", @"画画"]}],
            [[MMVMKVOUserModel alloc] initWithDict:@{@"name":@"赵六", @"age":@35, @"address":@"深圳市福田区", @"hobbies":@[@"跑步", @"阅读"]}],
            [[MMVMKVOUserModel alloc] initWithDict:@{@"name":@"钱七", @"age":@28, @"address":@"杭州市西湖区", @"hobbies":@[@"摄影", @"旅行"]}]
        ];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) success(mockUsers);
        });
    });
}

- (void)addNewUser:(MMVMKVOUserModel *)user success:(MMVMKVOSuccessBlock)success failure:(MMVMKVOFailureBlock)failure {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success(@{@"code":@200, @"message":@"添加成功", @"data":user});
            }
        });
    });
}

@end
    