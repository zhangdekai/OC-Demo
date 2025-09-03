#import <UIKit/UIKit.h>

@class RACUserCellViewModel;

@interface RACUserListView : UIView

@property (nonatomic, strong, readonly) UIButton *addButton;
@property (nonatomic, strong, readonly) UITableView *tableView;

/// 更新列表数据
- (void)updateWithCellViewModels:(NSArray<RACUserCellViewModel *> *)cellViewModels;
/// 显示加载状态
- (void)showLoading;
/// 隐藏加载状态
- (void)hideLoading;
/// 显示错误信息
- (void)showError:(NSString *)errorMessage;

@end
