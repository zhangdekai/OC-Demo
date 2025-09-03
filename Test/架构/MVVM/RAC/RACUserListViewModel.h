#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

@class RACUserCellViewModel;

@interface RACUserListViewModel : NSObject

// 输出信号
@property (nonatomic, strong, readonly) RACSignal *cellViewModelsSignal;    // 用户列表数据信号
@property (nonatomic, strong, readonly) RACSignal *isLoadingSignal;         // 加载状态信号
@property (nonatomic, strong, readonly) RACSignal *errorMessageSignal;      // 错误信息信号
@property (nonatomic, strong, readonly) RACSignal *addSuccessSignal;        // 添加成功信号

// 公开方法
- (void)loadUserList;      // 加载用户列表
- (void)addNewUser;        // 添加新用户

@end
