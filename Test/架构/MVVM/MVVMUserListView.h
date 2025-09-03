#import <UIKit/UIKit.h>
#import "MVVMUserCellViewModel.h"

@protocol MVVMUserListViewDelegate <NSObject>
/// 添加按钮点击事件
- (void)addButtonTapped;

@end

@interface MVVMUserListView : UIView
/// 代理
@property (nonatomic, weak) id<MVVMUserListViewDelegate> delegate;
/// 数据源
@property (nonatomic, strong) NSArray<MVVMUserCellViewModel *> *cellViewModels;

/// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame;
/// 更新列表数据
- (void)updateWithCellViewModels:(NSArray<MVVMUserCellViewModel *> *)cellViewModels;
/// 显示加载状态
- (void)showLoading;
/// 隐藏加载状态
- (void)hideLoading;
/// 显示错误信息
- (void)showError:(NSString *)errorMsg;

@end
