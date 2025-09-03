#import "RACDataRepository.h"
#import "RACNetworkManager.h"
#import "RACUserModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACDataRepository ()

// 信号发送者
@property (nonatomic, strong) RACSubject *fetchSuccessSubject;
@property (nonatomic, strong) RACSubject *fetchFailureSubject;
@property (nonatomic, strong) RACSubject *addSuccessSubject;
@property (nonatomic, strong) RACSubject *addFailureSubject;

@property (nonatomic, strong) RACNetworkManager *networkManager;

@end

@implementation RACDataRepository

+ (instancetype)sharedRepository {
    static RACDataRepository *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        // 初始化信号发送者
        _fetchSuccessSubject = [RACSubject subject];
        _fetchFailureSubject = [RACSubject subject];
        _addSuccessSubject = [RACSubject subject];
        _addFailureSubject = [RACSubject subject];
        
        // 暴露信号
        _fetchSuccessSignal = _fetchSuccessSubject;// [_fetchSuccessSubject asSignal];
        _fetchFailureSignal = _fetchFailureSubject;// [_fetchFailureSubject asSignal];
        _addSuccessSignal = _addSuccessSubject;// [_addSuccessSubject asSignal];
        _addFailureSignal = _addFailureSubject;// [_addFailureSubject asSignal];
        
        // 初始化网络管理器
        _networkManager = [RACNetworkManager sharedManager];
    }
    return self;
}

#pragma mark - 公开方法

- (void)fetchUserList {
    @weakify(self);
    [self.networkManager getUserListWithSuccess:^(NSArray *userList) {
        @strongify(self);
        [self.fetchSuccessSubject sendNext:userList];
    } failure:^(NSError *error) {
        @strongify(self);
        [self.fetchFailureSubject sendNext:error];
    }];
}

- (void)addNewUser:(RACUserModel *)user {
    @weakify(self);
    [self.networkManager addNewUser:user success:^(RACUserModel *addedUser) {
        @strongify(self);
        [self.addSuccessSubject sendNext:addedUser];
    } failure:^(NSError *error) {
        @strongify(self);
        [self.addFailureSubject sendNext:error];
    }];
}

@end
