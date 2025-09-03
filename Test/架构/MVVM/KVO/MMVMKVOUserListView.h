#import <UIKit/UIKit.h>
#import "MMVMKVOUserCell.h"

@interface MMVMKVOUserListView : UIView
@property (nonatomic, copy) void(^addButtonTapped)(void);
@property (nonatomic, strong) UITableView *tableView;

- (void)updateWithCellViewModels:(NSArray<MMVMKVOUserCellViewModel *> *)cellViewModels;
- (void)showLoading;
- (void)hideLoading;
- (void)showError:(NSString *)errorMessage;

@end
    