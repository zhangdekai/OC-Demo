#import <Foundation/Foundation.h>
#import "MVCUserModel.h"

@protocol MVCDataManagerDelegate <NSObject>

// 数据加载成功
- (void)dataLoadSuccess:(NSArray<MVCUserModel *> *)userList;

// 数据加载失败
- (void)dataLoadFailed:(NSError *)error;

// 数据添加成功
- (void)dataAddSuccess;

@end

@interface MVCDataManager : NSObject

@property (nonatomic, weak) id<MVCDataManagerDelegate> delegate;
@property (nonatomic, strong, readonly) NSArray<MVCUserModel *> *userList;

+ (instancetype)sharedManager;

// 从网络获取用户列表
- (void)fetchUserList;

// 添加新用户
- (void)addNewUser;

@end
    