#import "MVVMUserListViewController.h"
#import "MVVMUserListViewModel.h"
#import "MVVMUserListView.h"
#import "MBProgressHUD.h"

@interface MVVMUserListViewController () <MVVMUserListViewModelDelegate, MVVMUserListViewDelegate>

@property (nonatomic, strong) MVVMUserListViewModel *viewModel;
@property (nonatomic, strong) MVVMUserListView *userListView;

@end

@implementation MVVMUserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化ViewModel和View
    [self setupViewModel];
    [self setupView];
    
    // 加载数据
    [self.viewModel loadUserList];
}

#pragma mark - 初始化

- (void)setupViewModel {
    _viewModel = [[MVVMUserListViewModel alloc] init];
    _viewModel.delegate = self;
}

- (void)setupView {
    _userListView = [[MVVMUserListView alloc] initWithFrame:self.view.bounds];
    _userListView.delegate = self;
    _userListView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_userListView];
}

#pragma mark - MVVMUserListViewModelDelegate

- (void)userListDidUpdate:(NSArray<MVVMUserCellViewModel *> *)cellViewModels {
    // 更新视图数据
    [self.userListView updateWithCellViewModels:cellViewModels];
}

- (void)loadingStateDidChange:(BOOL)isLoading {
    if (isLoading) {
        [self.userListView showLoading];
    } else {
        [self.userListView hideLoading];
    }
}

- (void)showErrorMsg:(NSString *)errorMsg {
    [self.userListView showError:errorMsg];
}

- (void)addUserSuccess {
    // 显示添加成功提示
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"添加成功";
    [hud hideAnimated:YES afterDelay:1];
}

#pragma mark - MVVMUserListViewDelegate

- (void)addButtonTapped {
    // 调用ViewModel的添加方法
    [self.viewModel addNewUser];
}

@end
