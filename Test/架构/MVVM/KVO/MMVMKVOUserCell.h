#import <UIKit/UIKit.h>
#import "MMVMKVOUserCellViewModel.h"

@interface MMVMKVOUserCell : UITableViewCell
@property (nonatomic, strong) MMVMKVOUserCellViewModel *viewModel;
+ (NSString *)reuseIdentifier;
@end
    