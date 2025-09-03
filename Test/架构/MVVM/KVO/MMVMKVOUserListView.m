#import "MMVMKVOUserListView.h"
#import "MBProgressHUD.h"

@interface MMVMKVOUserListView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray<MMVMKVOUserCellViewModel *> *cellViewModels;
@property (nonatomic, strong) UIButton *addButton;
@end

@implementation MMVMKVOUserListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
        [self setupConstraints];
    }
    return self;
}

- (void)setupSubviews {
    // 表格视图
    _tableView = [[UITableView alloc] init];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 120;
    [_tableView registerClass:[MMVMKVOUserCell class] forCellReuseIdentifier:[MMVMKVOUserCell reuseIdentifier]];
    [self addSubview:_tableView];
    
    // 添加按钮
    _addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _addButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_addButton setTitle:@"添加用户" forState:UIControlStateNormal];
    _addButton.backgroundColor = [UIColor systemBlueColor];
    [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _addButton.layer.cornerRadius = 8;
    [_addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addButton];
}

- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
        // 表格约束
        [_tableView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [_tableView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [_tableView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [_tableView.bottomAnchor constraintEqualToAnchor:_addButton.topAnchor constant:-20],
        
        // 添加按钮约束
        [_addButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:20],
        [_addButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-20],
        [_addButton.bottomAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.bottomAnchor constant:-20],
        [_addButton.heightAnchor constraintEqualToConstant:44]
    ]];
}

#pragma mark - 按钮点击事件
- (void)addButtonAction {
    if (self.addButtonTapped) {
        self.addButtonTapped();
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MMVMKVOUserCell *cell = [tableView dequeueReusableCellWithIdentifier:[MMVMKVOUserCell reuseIdentifier] forIndexPath:indexPath];
    cell.viewModel = self.cellViewModels[indexPath.row];
    return cell;
}

#pragma mark - 公开方法
- (void)updateWithCellViewModels:(NSArray<MMVMKVOUserCellViewModel *> *)cellViewModels {
    self.cellViewModels = cellViewModels;
    [self.tableView reloadData];
}

- (void)showLoading {
    [MBProgressHUD showHUDAddedTo:self animated:YES];
}

- (void)hideLoading {
    [MBProgressHUD hideHUDForView:self animated:YES];
}

- (void)showError:(NSString *)errorMessage {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = errorMessage;
    [hud hideAnimated:YES afterDelay:2];
}

@end
    
