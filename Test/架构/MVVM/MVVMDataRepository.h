#import <Foundation/Foundation.h>
#import "MVVMUserModel.h"

@protocol MVVMDataRepositoryDelegate <NSObject>
/// 获取用户列表成功
- (void)fetchUserListSuccess:(NSArray<MVVMUserModel *> *)userList;
/// 获取用户列表失败
- (void)fetchUserListFailure:(NSError *)error;
/// 添加用户成功
- (void)addUserSuccess:(MVVMUserModel *)newUser;
/// 添加用户失败
- (void)addUserFailure:(NSError *)error;

@end

@interface MVVMDataRepository : NSObject
/// 代理（通知ViewModel结果）
@property (nonatomic, weak) id<MVVMDataRepositoryDelegate> delegate;
/// 单例实例
+ (instancetype)sharedRepository;

/// 发起请求：获取用户列表
- (void)fetchUserList;
/// 发起请求：添加新用户
- (void)addNewUser:(MVVMUserModel *)user;

@end
