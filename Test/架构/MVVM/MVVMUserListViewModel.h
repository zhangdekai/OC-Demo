#import <Foundation/Foundation.h>
#import "MVVMUserCellViewModel.h"

@protocol MVVMUserListViewModelDelegate <NSObject>
/// 列表数据更新（需刷新UI）
- (void)userListDidUpdate:(NSArray<MVVMUserCellViewModel *> *)cellViewModels;
/// 加载状态变化（显示/隐藏加载框）
- (void)loadingStateDidChange:(BOOL)isLoading;
/// 错误信息提示（如网络失败）
- (void)showErrorMsg:(NSString *)errorMsg;
/// 添加用户成功提示
- (void)addUserSuccess;

@end

@interface MVVMUserListViewModel : NSObject
/// 代理（通知View/Controller更新）
@property (nonatomic, weak) id<MVVMUserListViewModelDelegate> delegate;
/// 单元格ViewModel数组（View直接使用的数据源）
@property (nonatomic, strong, readonly) NSArray<MVVMUserCellViewModel *> *cellViewModels;

/// 初始化方法
- (instancetype)init;
/// 加载用户列表（对外提供的交互方法）
- (void)loadUserList;
/// 添加新用户（对外提供的交互方法）
- (void)addNewUser;

@end
