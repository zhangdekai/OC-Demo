#import "RACUserListView.h"
#import "RACUserCell.h"
#import "RACUserCellViewModel.h"
#import "MBProgressHUD.h"

@interface RACUserListView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<RACUserCellViewModel *> *cellViewModels;

@end

@implementation RACUserListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _cellViewModels = @[];
        [self setupSubviews];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - 初始化视图

- (void)setupSubviews {
    self.backgroundColor = [UIColor whiteColor];
    
    // 添加按钮
    _addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _addButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_addButton setTitle:@"添加用户" forState:UIControlStateNormal];
    _addButton.backgroundColor = [UIColor systemBlueColor];
    [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _addButton.layer.cornerRadius = 8;
    [self addSubview:_addButton];
    
    // 表格视图
    _tableView = [[UITableView alloc] init];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 120;
    [_tableView registerClass:[RACUserCell class] forCellReuseIdentifier:@"RACUserCell"];
    [self addSubview:_tableView];
}

- (void)setupConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_addButton, _tableView);
    
    [NSLayoutConstraint activateConstraints:@[
        // 添加按钮约束
        [NSLayoutConstraint constraintWithItem:self.addButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20],
        [NSLayoutConstraint constraintWithItem:self.addButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-20],
        [NSLayoutConstraint constraintWithItem:self.addButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100],
        [NSLayoutConstraint constraintWithItem:self.addButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44],
        
        // 表格约束
        [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.addButton attribute:NSLayoutAttributeTop multiplier:1.0 constant:-20]
    ]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RACUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RACUserCell" forIndexPath:indexPath];
    cell.viewModel = self.cellViewModels[indexPath.row];
    return cell;
}

#pragma mark - 公开方法

- (void)updateWithCellViewModels:(NSArray<RACUserCellViewModel *> *)cellViewModels {
    _cellViewModels = cellViewModels;
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
