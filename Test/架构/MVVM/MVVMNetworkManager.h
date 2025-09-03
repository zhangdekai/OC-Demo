#import <Foundation/Foundation.h>
#import "MVVMUserModel.h"

/// 网络请求成功回调
typedef void(^MVVMSuccessBlock)(id response);
/// 网络请求失败回调
typedef void(^MVVMFailureBlock)(NSError *error);

@interface MVVMNetworkManager : NSObject
/// 单例实例
+ (instancetype)sharedManager;

/// 模拟GET请求（获取用户列表）
- (void)getUserListWithSuccess:(MVVMSuccessBlock)success failure:(MVVMFailureBlock)failure;

/// 模拟POST请求（添加新用户）
- (void)addNewUser:(MVVMUserModel *)user success:(MVVMSuccessBlock)success failure:(MVVMFailureBlock)failure;

@end
