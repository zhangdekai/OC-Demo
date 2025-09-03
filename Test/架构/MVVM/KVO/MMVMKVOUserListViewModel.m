#import "MMVMKVOUserListViewModel.h"
#import "MMVMKVODataRepository.h"
#import "MMVMKVOUserModel.h"

@interface MMVMKVOUserListViewModel () <MMVMKVODataRepositoryDelegate>
@property (nonatomic, strong) NSMutableArray<MMVMKVOUserCellViewModel *> *mutableCellViewModels;
@property (nonatomic, assign) BOOL mutableIsLoading;
@property (nonatomic, copy) NSString *mutableErrorMessage;
@property (nonatomic, strong) MMVMKVODataRepository *dataRepository;
@property (nonatomic, strong) NSArray<MMVMKVOUserModel *> *userList;
@end

@implementation MMVMKVOUserListViewModel

- (instancetype)init {
    if (self = [super init]) {
        _mutableCellViewModels = [NSMutableArray array];
        _dataRepository = [MMVMKVODataRepository sharedRepository];
        _dataRepository.delegate = self;
        _userList = @[];
        _addSuccess = NO;
    }
    return self;
}

#pragma mark - 公开属性的getter方法
- (NSArray<MMVMKVOUserCellViewModel *> *)cellViewModels {
    return [self.mutableCellViewModels copy];
}

- (BOOL)isLoading {
    return self.mutableIsLoading;
}

- (NSString *)errorMessage {
    return self.mutableErrorMessage;
}

#pragma mark - 公开方法
- (void)loadUserList {
    self.mutableIsLoading = YES;
    self.mutableErrorMessage = nil;
    [self.dataRepository fetchUserList];
}

- (void)addNewUser {
    self.mutableIsLoading = YES;
    self.mutableErrorMessage = nil;
    self.addSuccess = NO;
    
    MMVMKVOUserModel *newUser = [MMVMKVOUserModel mockUser];
    [self.dataRepository addNewUser:newUser];
}

#pragma mark - 内部方法
- (void)updateCellViewModels {
    [self willChangeValueForKey:@"cellViewModels"];
    [self.mutableCellViewModels removeAllObjects];
    
    for (MMVMKVOUserModel *user in self.userList) {
        MMVMKVOUserCellViewModel *cellVM = [[MMVMKVOUserCellViewModel alloc] initWithUserModel:user];
        [self.mutableCellViewModels addObject:cellVM];
    }
    
    [self didChangeValueForKey:@"cellViewModels"];
}

#pragma mark - MMVMKVODataRepositoryDelegate
- (void)fetchUserListSuccess:(NSArray<MMVMKVOUserModel *> *)userList {
    self.userList = userList;
    [self updateCellViewModels];
    self.mutableIsLoading = NO;
}

- (void)fetchUserListFailure:(NSError *)error {
    self.mutableErrorMessage = error.localizedDescription ?: @"加载失败";
    self.mutableIsLoading = NO;
}

- (void)addUserSuccess:(MMVMKVOUserModel *)newUser {
    NSMutableArray *newList = [self.userList mutableCopy];
    [newList addObject:newUser];
    self.userList = [newList copy];
    
    [self updateCellViewModels];
    self.mutableIsLoading = NO;
    self.addSuccess = YES;
}

- (void)addUserFailure:(NSError *)error {
    self.mutableErrorMessage = error.localizedDescription ?: @"添加失败";
    self.mutableIsLoading = NO;
}

@end
    