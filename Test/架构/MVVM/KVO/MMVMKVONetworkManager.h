#import <Foundation/Foundation.h>
#import "MMVMKVOUserModel.h"

typedef void(^MMVMKVOSuccessBlock)(id response);
typedef void(^MMVMKVOFailureBlock)(NSError *error);

@interface MMVMKVONetworkManager : NSObject
+ (instancetype)sharedManager;

/// 模拟获取用户列表
- (void)getUserListWithSuccess:(MMVMKVOSuccessBlock)success failure:(MMVMKVOFailureBlock)failure;

/// 模拟添加新用户
- (void)addNewUser:(MMVMKVOUserModel *)user success:(MMVMKVOSuccessBlock)success failure:(MMVMKVOFailureBlock)failure;

@end
    