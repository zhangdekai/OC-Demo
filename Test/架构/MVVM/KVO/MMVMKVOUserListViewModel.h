#import <Foundation/Foundation.h>
#import "MMVMKVOUserCellViewModel.h"

@interface MMVMKVOUserListViewModel : NSObject
/// 单元格ViewModel数组（可被KVO观察）
@property (nonatomic, strong, readonly) NSArray<MMVMKVOUserCellViewModel *> *cellViewModels;
/// 加载状态（可被KVO观察）
@property (nonatomic, assign, readonly) BOOL isLoading;
/// 错误信息（可被KVO观察）
@property (nonatomic, copy, readonly) NSString *errorMessage;
/// 添加成功标识（可被KVO观察）
@property (nonatomic, assign) BOOL addSuccess;

- (instancetype)init;
- (void)loadUserList;
- (void)addNewUser;

@end
    