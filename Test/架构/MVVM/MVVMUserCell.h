#import <UIKit/UIKit.h>
#import "MVVMUserCellViewModel.h"

@interface MVVMUserCell : UITableViewCell
/// 单元格ViewModel，设置后自动更新UI
@property (nonatomic, strong) MVVMUserCellViewModel *viewModel;

/// 重用标识符
+ (NSString *)reuseIdentifier;

@end
