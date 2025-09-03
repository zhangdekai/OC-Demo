#import "MVVMDataRepository.h"
#import "MVVMNetworkManager.h"

@implementation MVVMDataRepository

+ (instancetype)sharedRepository {
    static MVVMDataRepository *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)fetchUserList {
    [[MVVMNetworkManager sharedManager] getUserListWithSuccess:^(id response) {
        // 网络请求成功，将响应转为UserModel数组，通知ViewModel
        if ([response isKindOfClass:[NSArray class]]) {
            NSArray<MVVMUserModel *> *userList = (NSArray<MVVMUserModel *> *)response;
            if ([self.delegate respondsToSelector:@selector(fetchUserListSuccess:)]) {
                [self.delegate fetchUserListSuccess:userList];
            }
        }
    } failure:^(NSError *error) {
        // 网络请求失败，通知ViewModel
        if ([self.delegate respondsToSelector:@selector(fetchUserListFailure:)]) {
            [self.delegate fetchUserListFailure:error];
        }
    }];
}

- (void)addNewUser:(MVVMUserModel *)user {
    [[MVVMNetworkManager sharedManager] addNewUser:user success:^(id response) {
        // 添加成功，从响应中提取新用户，通知ViewModel
        MVVMUserModel *newUser = [[MVVMUserModel alloc] initWithDict:response[@"data"]];
        if ([self.delegate respondsToSelector:@selector(addUserSuccess:)]) {
            [self.delegate addUserSuccess:newUser];
        }
    } failure:^(NSError *error) {
        // 添加失败，通知ViewModel
        if ([self.delegate respondsToSelector:@selector(addUserFailure:)]) {
            [self.delegate addUserFailure:error];
        }
    }];
}

@end
