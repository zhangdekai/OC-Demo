#import "RACUserListViewModel.h"
#import "RACDataRepository.h"
#import "RACUserModel.h"
#import "RACUserCellViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACUserListViewModel ()

// 内部信号发送者
@property (nonatomic, strong) RACSubject *cellViewModelsSubject;
@property (nonatomic, strong) RACSubject *isLoadingSubject;
@property (nonatomic, strong) RACSubject *errorMessageSubject;
@property (nonatomic, strong) RACSubject *addSuccessSubject;

@property (nonatomic, strong) RACDataRepository *dataRepository;
@property (nonatomic, strong) NSArray<RACUserModel *> *userList;

@end

@implementation RACUserListViewModel

- (instancetype)init {
    if (self = [super init]) {
        // 初始化信号发送者
        _cellViewModelsSubject = [RACSubject subject];
        _isLoadingSubject = [RACSubject subject];
        _errorMessageSubject = [RACSubject subject];
        _addSuccessSubject = [RACSubject subject];
        
                
        // 暴露信号（外部只能订阅，不能发送）
        _cellViewModelsSignal = _cellViewModelsSubject;// [_cellViewModelsSubject asSignal];
        _isLoadingSignal = _isLoadingSubject;// [_isLoadingSubject asSignal];
        _errorMessageSignal = _errorMessageSubject;// [_errorMessageSubject asSignal];
        _addSuccessSignal = _addSuccessSubject;// [_addSuccessSubject asSignal];
        
        // 初始化数据仓库
        _dataRepository = [RACDataRepository sharedRepository];
        _userList = @[];
        
        // 绑定数据仓库信号
        [self bindDataRepositorySignals];
    }
    return self;
}

#pragma mark - 绑定数据仓库信号

- (void)bindDataRepositorySignals {
    @weakify(self);
    
    // 绑定用户列表获取成功信号
    [self.dataRepository.fetchSuccessSignal subscribeNext:^(NSArray *userList) {
        @strongify(self);
        self.userList = userList;
        [self convertAndSendCellViewModels];
        [self.isLoadingSubject sendNext:@(NO)];
    }];
    
    // 绑定用户列表获取失败信号
    [self.dataRepository.fetchFailureSignal subscribeNext:^(NSError *error) {
        @strongify(self);
        [self.errorMessageSubject sendNext:error.localizedDescription ?: @"加载失败"];
        [self.isLoadingSubject sendNext:@(NO)];
    }];
    
    // 绑定添加用户成功信号
    [self.dataRepository.addSuccessSignal subscribeNext:^(RACUserModel *newUser) {
        @strongify(self);
        // 添加新用户到列表
        NSMutableArray *newList = [self.userList mutableCopy];
        [newList addObject:newUser];
        self.userList = [newList copy];
        
        [self convertAndSendCellViewModels];
        [self.isLoadingSubject sendNext:@(NO)];
        [self.addSuccessSubject sendNext:@(YES)];
    }];
    
    // 绑定添加用户失败信号
    [self.dataRepository.addFailureSignal subscribeNext:^(NSError *error) {
        @strongify(self);
        [self.errorMessageSubject sendNext:error.localizedDescription ?: @"添加失败"];
        [self.isLoadingSubject sendNext:@(NO)];
    }];
}

#pragma mark - 数据转换与发送

- (void)convertAndSendCellViewModels {
    // 将UserModel转换为CellViewModel
    NSMutableArray *cellViewModels = [NSMutableArray array];
    for (RACUserModel *user in self.userList) {
        RACUserCellViewModel *cellVM = [[RACUserCellViewModel alloc] initWithUserModel:user];
        [cellViewModels addObject:cellVM];
    }
    
    // 发送数据信号
    [self.cellViewModelsSubject sendNext:cellViewModels];
}

#pragma mark - 公开方法

- (void)loadUserList {
    [self.isLoadingSubject sendNext:@(YES)];
    [self.dataRepository fetchUserList];
}

- (void)addNewUser {
    [self.isLoadingSubject sendNext:@(YES)];
    RACUserModel *newUser = [RACUserModel mockUser];
    [self.dataRepository addNewUser:newUser];
}

@end
