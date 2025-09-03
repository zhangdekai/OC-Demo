#import "MMVMKVOUserListViewController.h"
#import "MMVMKVOUserListViewModel.h"
#import "MMVMKVOUserListView.h"
#import "MBProgressHUD.h"

// KVO上下文定义
static void *kCellViewModelsContext = &kCellViewModelsContext;
static void *kIsLoadingContext = &kIsLoadingContext;
static void *kErrorMessageContext = &kErrorMessageContext;
static void *kAddSuccessContext = &kAddSuccessContext;

@interface MMVMKVOUserListViewController ()
@property (nonatomic, strong) MMVMKVOUserListViewModel *viewModel;
@property (nonatomic, strong) MMVMKVOUserListView *userListView;
@end

@implementation MMVMKVOUserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户列表";
    [self setupViewModel];
    [self setupView];
    [self setupKVO];
    
    // 加载数据
    [self.viewModel loadUserList];
}

#pragma mark - 初始化
- (void)setupViewModel {
    _viewModel = [[MMVMKVOUserListViewModel alloc] init];
}

- (void)setupView {
    _userListView = [[MMVMKVOUserListView alloc] initWithFrame:self.view.bounds];
    _userListView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    __weak typeof(self) weakSelf = self;
    _userListView.addButtonTapped = ^{
        [weakSelf.viewModel addNewUser];
    };
    [self.view addSubview:_userListView];
}

- (void)setupKVO {
    // 注册KVO观察
    [self.viewModel addObserver:self
                     forKeyPath:@"cellViewModels"
                        options:NSKeyValueObservingOptionNew
                        context:kCellViewModelsContext];
    
    [self.viewModel addObserver:self
                     forKeyPath:@"isLoading"
                        options:NSKeyValueObservingOptionNew
                        context:kIsLoadingContext];
    
    [self.viewModel addObserver:self
                     forKeyPath:@"errorMessage"
                        options:NSKeyValueObservingOptionNew
                        context:kErrorMessageContext];
    
    [self.viewModel addObserver:self
                     forKeyPath:@"addSuccess"
                        options:NSKeyValueObservingOptionNew
                        context:kAddSuccessContext];
}

#pragma mark - KVO回调
- (void)observeValueForKeyPath:(NSString *)keyPath 
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    
    // 检查上下文，避免处理无关的KVO通知
    if (context == kCellViewModelsContext) {
        // 单元格数据变化，更新表格
        NSArray *newValue = change[NSKeyValueChangeNewKey];
        [self.userListView updateWithCellViewModels:newValue];
    }
    else if (context == kIsLoadingContext) {
        // 加载状态变化
        BOOL isLoading = [change[NSKeyValueChangeNewKey] boolValue];
        if (isLoading) {
            [self.userListView showLoading];
        } else {
            [self.userListView hideLoading];
        }
    }
    else if (context == kErrorMessageContext) {
        // 错误信息变化
        NSString *errorMsg = change[NSKeyValueChangeNewKey];
        if (errorMsg) {
            [self.userListView showError:errorMsg];
        }
    }
    else if (context == kAddSuccessContext) {
        // 添加成功
        BOOL addSuccess = [change[NSKeyValueChangeNewKey] boolValue];
        if (addSuccess) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"添加成功";
            [hud hideAnimated:YES afterDelay:1];
        }
    }
    else {
        // 调用父类方法处理其他KVO通知
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - 内存管理
- (void)dealloc {
    // 移除KVO观察，防止崩溃
    [self.viewModel removeObserver:self forKeyPath:@"cellViewModels" context:kCellViewModelsContext];
    [self.viewModel removeObserver:self forKeyPath:@"isLoading" context:kIsLoadingContext];
    [self.viewModel removeObserver:self forKeyPath:@"errorMessage" context:kErrorMessageContext];
    [self.viewModel removeObserver:self forKeyPath:@"addSuccess" context:kAddSuccessContext];
}

@end

