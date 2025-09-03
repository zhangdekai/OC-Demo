#import "MVVMUserListView.h"
#import "MVVMUserCell.h"
#import "MBProgressHUD.h"

@interface MVVMUserListView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation MVVMUserListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - 初始化视图

- (void)setupSubviews {
    // 表格视图
    _tableView = [[UITableView alloc] init];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 120;
    [_tableView registerClass:[MVVMUserCell class] forCellReuseIdentifier:[MVVMUserCell reuseIdentifier]];
    [self addSubview:_tableView];
    
    // 添加按钮
    _addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _addButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_addButton setTitle:@"添加用户" forState:UIControlStateNormal];
    _addButton.backgroundColor = [UIColor systemBlueColor];
    [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _addButton.layer.cornerRadius = 8;
    [_addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addButton];
    
    // 加载指示器
    _hud = [MBProgressHUD HUDForView:self];
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        _hud.hidden = YES;
    }
}

- (void)setupConstraints {
    // 表格约束
    [NSLayoutConstraint activateConstraints:@[
        [_tableView.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor],
        [_tableView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [_tableView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [_tableView.bottomAnchor constraintEqualToAnchor:_addButton.topAnchor constant:-16]
    ]];
    
    // 添加按钮约束
    [NSLayoutConstraint activateConstraints:@[
        [_addButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:16],
        [_addButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-16],
        [_addButton.bottomAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.bottomAnchor constant:-16],
        [_addButton.heightAnchor constraintEqualToConstant:44]
    ]];
}

#pragma mark - 事件处理

- (void)addButtonClicked {
    if ([self.delegate respondsToSelector:@selector(addButtonTapped)]) {
        [self.delegate addButtonTapped];
    }
}

#pragma mark - UITableViewDataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MVVMUserCell *cell = [tableView dequeueReusableCellWithIdentifier:[MVVMUserCell reuseIdentifier] forIndexPath:indexPath];
    cell.viewModel = self.cellViewModels[indexPath.row];
    return cell;
}

#pragma mark - 公共方法

- (void)updateWithCellViewModels:(NSArray<MVVMUserCellViewModel *> *)cellViewModels {
    self.cellViewModels = cellViewModels;
    [self.tableView reloadData];
}

- (void)showLoading {
    _hud.hidden = NO;
    _hud.label.text = @"加载中...";
}

- (void)hideLoading {
    [_hud hideAnimated:YES];
}

- (void)showError:(NSString *)errorMsg {
    MBProgressHUD *errorHud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    errorHud.mode = MBProgressHUDModeText;
    errorHud.label.text = errorMsg;
    [errorHud hideAnimated:YES afterDelay:2];
}

@end
