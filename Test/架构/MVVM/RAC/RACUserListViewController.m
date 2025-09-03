#import "RACUserListViewController.h"
#import "RACUserListViewModel.h"
#import "RACUserListView.h"
//#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "MBProgressHUD.h"

@interface RACUserListViewController ()

@property (nonatomic, strong) RACUserListViewModel *viewModel;
@property (nonatomic, strong) RACUserListView *userListView;

@end

@implementation RACUserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RAC用户列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化组件
    [self setupViewModel];
    [self setupView];
    // 绑定信号
    [self bindSignals];
    
    // 加载数据
    [self.viewModel loadUserList];
}

#pragma mark - 初始化

- (void)setupViewModel {
    _viewModel = [[RACUserListViewModel alloc] init];
}

- (void)setupView {
    _userListView = [[RACUserListView alloc] initWithFrame:self.view.bounds];
    _userListView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_userListView];
}

#pragma mark - RAC信号绑定

- (void)bindSignals {
    @weakify(self);
    
    // 1. 绑定用户列表数据到表格
    [self.viewModel.cellViewModelsSignal subscribeNext:^(NSArray *cellViewModels) {
        @strongify(self);
        [self.userListView updateWithCellViewModels:cellViewModels];
    }];
    
    // 2. 绑定加载状态到加载指示器
    [self.viewModel.isLoadingSignal subscribeNext:^(NSNumber *isLoadingNumber) {
        @strongify(self);
        BOOL isLoading = [isLoadingNumber boolValue];
        if (isLoading) {
            [self.userListView showLoading];
        } else {
            [self.userListView hideLoading];
        }
    }];
    
    // 3. 绑定错误信息到错误提示
    [self.viewModel.errorMessageSignal subscribeNext:^(NSString *errorMessage) {
        @strongify(self);
        [self.userListView showError:errorMessage];
    }];
    
    // 4. 绑定添加成功信号到提示框
    [self.viewModel.addSuccessSignal subscribeNext:^(id x) {
        @strongify(self);
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"添加成功";
        [hud hideAnimated:YES afterDelay:1];
    }];
    
    // 5. 绑定添加按钮点击事件到ViewModel
    [[self.userListView.addButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(UIButton *button) {
         @strongify(self);
         [self.viewModel addNewUser];
     }];
}

@end
