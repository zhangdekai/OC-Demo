#import "MVCDataManager.h"
#import "MVCNetworkManager.h"

@implementation MVCDataManager

#pragma mark - 单例

+ (instancetype)sharedManager {
    static MVCDataManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MVCDataManager alloc] init];
    });
    return instance;
}

#pragma mark - 公共方法

- (void)fetchUserList {
    // 调用网络层获取数据
    [[MVCNetworkManager sharedManager] GET:@"https://api.example.com/users" 
                                parameters:nil 
                                   success:^(id responseObject) {
        // 解析数据
        NSArray *userArray = responseObject;
        NSMutableArray *userList = [NSMutableArray array];
        
        for (NSDictionary *dict in userArray) {
            MVCUserModel *user = [[MVCUserModel alloc] initWithDictionary:dict];
            [userList addObject:user];
        }
        
        // 保存数据
        self->_userList = userList.copy;
        
        // 通知控制器
        if ([self.delegate respondsToSelector:@selector(dataLoadSuccess:)]) {
            [self.delegate dataLoadSuccess:self->_userList];
        }
    } failure:^(NSError *error) {
        // 通知控制器加载失败
        if ([self.delegate respondsToSelector:@selector(dataLoadFailed:)]) {
            [self.delegate dataLoadFailed:error];
        }
    }];
}

- (void)addNewUser {
    // 创建新用户数据
    NSDictionary *newUserDict = @{
        @"userId": [NSString stringWithFormat:@"%d", arc4random_uniform(10000)],
        @"name": [self randomName],
        @"age": @(18 + arc4random_uniform(40)),
        @"address": [self randomAddress],
        @"hobby": [self randomHobby]
    };
    
    // 调用网络层添加数据
    [[MVCNetworkManager sharedManager] POST:@"https://api.example.com/users" 
                                 parameters:newUserDict 
                                    success:^(id responseObject) {
        // 添加成功后重新获取列表
        [self fetchUserList];
        
        // 通知控制器添加成功     // 通过代理通知Controller
        if ([self.delegate respondsToSelector:@selector(dataAddSuccess)]) {
            [self.delegate dataAddSuccess];
        }
    } failure:^(NSError *error) {
        // 通知控制器添加失败
        if ([self.delegate respondsToSelector:@selector(dataLoadFailed:)]) {
            [self.delegate dataLoadFailed:error];
        }
    }];
}

#pragma mark - 辅助方法

// 随机生成姓名
- (NSString *)randomName {
    NSArray *firstNames = @[@"张三", @"李四", @"王五", @"赵六", @"钱七", @"孙八", @"周九", @"吴十"];
    return firstNames[arc4random_uniform(firstNames.count)];
}

// 随机生成地址
- (NSString *)randomAddress {
    NSArray *cities = @[@"北京市", @"上海市", @"广州市", @"深圳市", @"杭州市", @"南京市"];
    NSArray *districts = @[@"朝阳区", @"海淀区", @"静安区", @"浦东新区", @"天河区", @"南山区"];
    NSArray *roads = @[@"人民路", @"解放路", @"中山路", @"建设路", @"和平路"];
    
    return [NSString stringWithFormat:@"%@%@%@%d号",
            cities[arc4random_uniform(cities.count)],
            districts[arc4random_uniform(districts.count)],
            roads[arc4random_uniform(roads.count)],
            arc4random_uniform(1000)];
}

// 随机生成爱好
- (NSString *)randomHobby {
    NSArray *hobbies = @[@"读书", @"运动", @"旅游", @"音乐", @"电影", @"摄影", @"美食", @"游戏"];
    return hobbies[arc4random_uniform(hobbies.count)];
}

@end
    
