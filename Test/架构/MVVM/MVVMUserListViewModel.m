#import "MVVMUserListViewModel.h"
#import "MVVMDataRepository.h"
#import "MVVMUserModel.h"

@interface MVVMUserListViewModel () <MVVMDataRepositoryDelegate>
/// 存储原始UserModel数组
@property (nonatomic, strong) NSMutableArray<MVVMUserModel *> *userList;
/// 单元格ViewModel数组（内部可变版本）
@property (nonatomic, strong) NSMutableArray<MVVMUserCellViewModel *> *mutableCellViewModels;
/// 数据仓库（依赖注入，解耦网络）
@property (nonatomic, strong) MVVMDataRepository *dataRepository;

@end

@implementation MVVMUserListViewModel

- (instancetype)init {
    if (self = [super init]) {
        // 初始化数据仓库，并设置代理（接收数据结果）
        _dataRepository = [MVVMDataRepository sharedRepository];
        _dataRepository.delegate = self;
        
        // 初始化为空数组，避免View加载时崩溃
        _userList = [NSMutableArray array];
        _mutableCellViewModels = [NSMutableArray array];
        _cellViewModels = [_mutableCellViewModels copy];
    }
    return self;
}

/// 加载用户列表（对外暴露的方法，Controller/View可调用）
- (void)loadUserList {
    // 通知View显示加载框
    if ([self.delegate respondsToSelector:@selector(loadingStateDidChange:)]) {
        [self.delegate loadingStateDidChange:YES];
    }
    // 调用数据仓库发起请求（ViewModel不直接操作网络）
    [self.dataRepository fetchUserList];
}

/// 添加新用户（对外暴露的方法）
- (void)addNewUser {
    // 通知View显示加载框
    if ([self.delegate respondsToSelector:@selector(loadingStateDidChange:)]) {
        [self.delegate loadingStateDidChange:YES];
    }
    // 生成模拟用户（实际项目中可能从View接收用户输入）
    MVVMUserModel *newUser = [MVVMUserModel mockUser];
    // 调用数据仓库发起添加请求
    [self.dataRepository addNewUser:newUser];
}

#pragma mark - MVVMDataRepositoryDelegate（接收数据仓库的结果）
- (void)fetchUserListSuccess:(NSArray<MVVMUserModel *> *)userList {
    // 1. 保存原始UserModel数组
    [self.userList removeAllObjects];
    [self.userList addObjectsFromArray:userList];
    
    // 2. 将UserModel数组转为CellViewModel数组（数据转换）
    [self.mutableCellViewModels removeAllObjects];
    for (MVVMUserModel *user in userList) {
        [self.mutableCellViewModels addObject:[[MVVMUserCellViewModel alloc] initWithUserModel:user]];
    }
    _cellViewModels = [self.mutableCellViewModels copy];
    
    // 3. 通知View：数据更新+隐藏加载框
    if ([self.delegate respondsToSelector:@selector(userListDidUpdate:)]) {
        [self.delegate userListDidUpdate:self.cellViewModels];
    }
    if ([self.delegate respondsToSelector:@selector(loadingStateDidChange:)]) {
        [self.delegate loadingStateDidChange:NO];
    }
}

- (void)fetchUserListFailure:(NSError *)error {
    // 通知View：显示错误+隐藏加载框
    if ([self.delegate respondsToSelector:@selector(showErrorMsg:)]) {
        [self.delegate showErrorMsg:error.localizedDescription ?: @"获取用户列表失败"];
    }
    if ([self.delegate respondsToSelector:@selector(loadingStateDidChange:)]) {
        [self.delegate loadingStateDidChange:NO];
    }
}

- (void)addUserSuccess:(MVVMUserModel *)newUser {
    // 1. 将新用户添加到本地列表
    [self.userList addObject:newUser];
    
    // 2. 转换为CellViewModel并添加到列表
    MVVMUserCellViewModel *cellVM = [[MVVMUserCellViewModel alloc] initWithUserModel:newUser];
    [self.mutableCellViewModels addObject:cellVM];
    _cellViewModels = [self.mutableCellViewModels copy];
    
    // 3. 通知View：数据更新+隐藏加载框+显示成功提示
    if ([self.delegate respondsToSelector:@selector(userListDidUpdate:)]) {
        [self.delegate userListDidUpdate:self.cellViewModels];
    }
    if ([self.delegate respondsToSelector:@selector(loadingStateDidChange:)]) {
        [self.delegate loadingStateDidChange:NO];
    }
    if ([self.delegate respondsToSelector:@selector(addUserSuccess)]) {
        [self.delegate addUserSuccess];
    }
}

- (void)addUserFailure:(NSError *)error {
    // 通知View：显示错误+隐藏加载框
    if ([self.delegate respondsToSelector:@selector(showErrorMsg:)]) {
        [self.delegate showErrorMsg:error.localizedDescription ?: @"添加用户失败"];
    }
    if ([self.delegate respondsToSelector:@selector(loadingStateDidChange:)]) {
        [self.delegate loadingStateDidChange:NO];
    }
}

@end
