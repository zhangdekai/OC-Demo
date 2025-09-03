#import <Foundation/Foundation.h>

@class RACUserModel;

// 成功回调
typedef void(^RACSuccessBlock)(id response);
// 失败回调
typedef void(^RACFailureBlock)(NSError *error);

@interface RACNetworkManager : NSObject

// 单例
+ (instancetype)sharedManager;

// 获取用户列表
- (void)getUserListWithSuccess:(RACSuccessBlock)success failure:(RACFailureBlock)failure;

// 添加新用户
- (void)addNewUser:(RACUserModel *)user success:(RACSuccessBlock)success failure:(RACFailureBlock)failure;

@end
