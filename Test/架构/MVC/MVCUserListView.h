#import <UIKit/UIKit.h>
#import "MVCUserModel.h"

@protocol MVCUserListViewDelegate <NSObject>

// 添加按钮点击事件
- (void)addButtonTapped;

@end

@interface MVCUserListView : UIView

@property (nonatomic, weak) id<MVCUserListViewDelegate> delegate;

// 更新列表数据
- (void)updateWithUserList:(NSArray<MVCUserModel *> *)userList;

// 显示加载状态
- (void)showLoading;

// 隐藏加载状态
- (void)hideLoading;

// 显示错误信息
- (void)showError:(NSString *)errorMessage;

@end
    