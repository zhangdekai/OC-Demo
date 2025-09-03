#import "MVCUserListViewController.h"
#import "MVCDataManager.h"
#import "MVCUserListView.h"
#import "MBProgressHUD.h"

@interface MVCUserListViewController () <MVCDataManagerDelegate, MVCUserListViewDelegate>

@property (nonatomic, strong) MVCDataManager *dataManager;
@property (nonatomic, strong) MVCUserListView *userListView;

@end

@implementation MVCUserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化数据管理器
    [self setupDataManager];
    
    // 初始化视图
    [self setupView];
    
    // 加载数据
    [self loadData];
}

#pragma mark - 初始化

- (void)setupDataManager {
    _dataManager = [MVCDataManager sharedManager];
    _dataManager.delegate = self;
}

- (void)setupView {
    _userListView = [[MVCUserListView alloc] initWithFrame:self.view.bounds];
    _userListView.delegate = self;
    _userListView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_userListView];
}

#pragma mark - 数据加载

- (void)loadData {
    [_userListView showLoading];
    [_dataManager fetchUserList];
}

#pragma mark - MVCDataManagerDelegate

- (void)dataLoadSuccess:(NSArray<MVCUserModel *> *)userList {
    [_userListView hideLoading];
    [_userListView updateWithUserList:userList];
}

- (void)dataLoadFailed:(NSError *)error {
    [_userListView hideLoading];
    [_userListView showError:error.localizedDescription ?: @"加载失败，请重试"];
}

- (void)dataAddSuccess {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [MBProgressHUD hideHUDForView:self.view animated:YES];//:self.view animated:YES afterDelay:1];
}

#pragma mark - MVCUserListViewDelegate

- (void)addButtonTapped {
    [_userListView showLoading];
    [_dataManager addNewUser];
}

@end
    
