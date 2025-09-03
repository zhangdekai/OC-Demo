#import "MVCNetworkManager.h"

@implementation MVCNetworkManager

#pragma mark - 单例

+ (instancetype)sharedManager {
    static MVCNetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MVCNetworkManager alloc] init];
    });
    return instance;
}

#pragma mark - 公共方法

- (void)GET:(NSString *)url 
 parameters:(NSDictionary *)parameters 
    success:(SuccessBlock)success 
    failure:(FailureBlock)failure {
    // 模拟网络请求延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 模拟返回用户列表数据
        NSArray *mockData = @[
            @{@"userId": @"1001", @"name": @"张三", @"age": @25, @"address": @"北京市朝阳区人民大道100号", @"hobby": @"读书"},
            @{@"userId": @"1002", @"name": @"李四", @"age": @30, @"address": @"上海市静安区南京西路200号", @"hobby": @"运动"},
            @{@"userId": @"1003", @"name": @"王五", @"age": @28, @"address": @"广州市天河区珠江新城300号", @"hobby": @"旅游"}
        ];
        
        // 回到主线程回调
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success(mockData);
            }
        });
    });
}

- (void)POST:(NSString *)url 
  parameters:(NSDictionary *)parameters 
     success:(SuccessBlock)success 
     failure:(FailureBlock)failure {
    // 模拟网络请求延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 模拟POST请求成功
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success(@{@"status": @"success", @"message": @"添加成功"});
            }
        });
    });
}

@end
    