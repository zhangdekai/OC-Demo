#import "MVCUserListView.h"
#import "MVCUserCell.h"

@interface MVCUserListView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) NSArray<MVCUserModel *> *userList;

@end

@implementation MVCUserListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - 初始化

- (void)setupSubviews {
    self.backgroundColor = [UIColor whiteColor];
    
    // 初始化表格
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100;
    [_tableView registerClass:[MVCUserCell class] forCellReuseIdentifier:@"MVCUserCell"];
    [self addSubview:_tableView];
    
    // 初始化添加按钮
    _addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_addButton setTitle:@"添加用户" forState:UIControlStateNormal];
    _addButton.backgroundColor = [UIColor systemBlueColor];
    [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _addButton.layer.cornerRadius = 8;
    [_addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addButton];
    
    // 初始化加载指示器
    _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    _loadingView.hidesWhenStopped = YES;
    [self addSubview:_loadingView];
    
    // 初始化错误提示
    _errorLabel = [[UILabel alloc] init];
    _errorLabel.textColor = [UIColor redColor];
    _errorLabel.hidden = YES;
    _errorLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_errorLabel];
}

- (void)setupConstraints {
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _addButton.translatesAutoresizingMaskIntoConstraints = NO;
    _loadingView.translatesAutoresizingMaskIntoConstraints = NO;
    _errorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        // 表格约束
        [_tableView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [_tableView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [_tableView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [_tableView.bottomAnchor constraintEqualToAnchor:_addButton.topAnchor constant:-16],
        
        // 添加按钮约束
        [_addButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:32],
        [_addButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-32],
        [_addButton.bottomAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.bottomAnchor constant:-16],
        [_addButton.heightAnchor constraintEqualToConstant:44],
        
        // 加载指示器约束
        [_loadingView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [_loadingView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        
        // 错误提示约束
        [_errorLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [_errorLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [_errorLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:32],
        [_errorLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-32]
    ]];
}

#pragma mark - 事件处理

- (void)addButtonClicked {
    if ([self.delegate respondsToSelector:@selector(addButtonTapped)]) {
        [self.delegate addButtonTapped];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MVCUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MVCUserCell" forIndexPath:indexPath];
    cell.user = self.userList[indexPath.row];
    return cell;
}

#pragma mark - 公共方法

- (void)updateWithUserList:(NSArray<MVCUserModel *> *)userList {
    self.userList = userList;
    [self.tableView reloadData];
}

- (void)showLoading {
    self.loadingView.hidden = NO;
    [self.loadingView startAnimating];
    self.errorLabel.hidden = YES;
}

- (void)hideLoading {
    [self.loadingView stopAnimating];
    self.loadingView.hidden = YES;
}

- (void)showError:(NSString *)errorMessage {
    self.errorLabel.text = errorMessage;
    self.errorLabel.hidden = NO;
}

@end
    