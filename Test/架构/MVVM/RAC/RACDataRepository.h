#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@class RACUserModel;

@interface RACDataRepository : NSObject

// 单例
+ (instancetype)sharedRepository;

// 数据信号
@property (nonatomic, strong, readonly) RACSignal *fetchSuccessSignal;   // 获取列表成功信号
@property (nonatomic, strong, readonly) RACSignal *fetchFailureSignal;   // 获取列表失败信号
@property (nonatomic, strong, readonly) RACSignal *addSuccessSignal;     // 添加成功信号
@property (nonatomic, strong, readonly) RACSignal *addFailureSignal;     // 添加失败信号

// 公开方法
- (void)fetchUserList;                  // 获取用户列表
- (void)addNewUser:(RACUserModel *)user; // 添加新用户

@end
