#import "MMVMKVODataRepository.h"
#import "MMVMKVONetworkManager.h"

@implementation MMVMKVODataRepository

+ (instancetype)sharedRepository {
    static MMVMKVODataRepository *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)fetchUserList {
    [[MMVMKVONetworkManager sharedManager] getUserListWithSuccess:^(id response) {
        if ([response isKindOfClass:[NSArray class]]) {
            if ([self.delegate respondsToSelector:@selector(fetchUserListSuccess:)]) {
                [self.delegate fetchUserListSuccess:(NSArray<MMVMKVOUserModel *> *)response];
            }
        }
    } failure:^(NSError *error) {
        if ([self.delegate respondsToSelector:@selector(fetchUserListFailure:)]) {
            [self.delegate fetchUserListFailure:error];
        }
    }];
}

- (void)addNewUser:(MMVMKVOUserModel *)user {
    [[MMVMKVONetworkManager sharedManager] addNewUser:user success:^(id response) {
        MMVMKVOUserModel *newUser = [[MMVMKVOUserModel alloc] initWithDict:response[@"data"]];
        if ([self.delegate respondsToSelector:@selector(addUserSuccess:)]) {
            [self.delegate addUserSuccess:newUser];
        }
    } failure:^(NSError *error) {
        if ([self.delegate respondsToSelector:@selector(addUserFailure:)]) {
            [self.delegate addUserFailure:error];
        }
    }];
}

@end
    