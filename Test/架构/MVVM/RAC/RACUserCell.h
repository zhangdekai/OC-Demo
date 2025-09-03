#import <UIKit/UIKit.h>

@class RACUserCellViewModel;

@interface RACUserCell : UITableViewCell

@property (nonatomic, strong) RACUserCellViewModel *viewModel;

@end
