#import <Foundation/Foundation.h>
#import "MMVMKVOUserModel.h"

@protocol MMVMKVODataRepositoryDelegate <NSObject>
- (void)fetchUserListSuccess:(NSArray<MMVMKVOUserModel *> *)userList;
- (void)fetchUserListFailure:(NSError *)error;
- (void)addUserSuccess:(MMVMKVOUserModel *)newUser;
- (void)addUserFailure:(NSError *)error;
@end

@interface MMVMKVODataRepository : NSObject
@property (nonatomic, weak) id<MMVMKVODataRepositoryDelegate> delegate;
+ (instancetype)sharedRepository;

- (void)fetchUserList;
- (void)addNewUser:(MMVMKVOUserModel *)user;

@end
    