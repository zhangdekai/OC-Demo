#import "MVVMUserCell.h"

@interface MVVMUserCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *ageLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *hobbiesLabel;
@property (nonatomic, strong) UIView *separatorView;

@end

@implementation MVVMUserCell

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
        [self setupConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - 初始化视图

- (void)setupSubviews {
    // 姓名标签
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _nameLabel.font = [UIFont boldSystemFontOfSize:18];
    _nameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_nameLabel];
    
    // 年龄标签
    _ageLabel = [[UILabel alloc] init];
    _ageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _ageLabel.font = [UIFont systemFontOfSize:14];
    _ageLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:_ageLabel];
    
    // 地址标签
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _addressLabel.font = [UIFont systemFontOfSize:14];
    _addressLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:_addressLabel];
    
    // 爱好标签
    _hobbiesLabel = [[UILabel alloc] init];
    _hobbiesLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _hobbiesLabel.font = [UIFont systemFontOfSize:14];
    _hobbiesLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:_hobbiesLabel];
    
    // 分隔线
    _separatorView = [[UIView alloc] init];
    _separatorView.translatesAutoresizingMaskIntoConstraints = NO;
    _separatorView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_separatorView];
}

- (void)setupConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_nameLabel, _ageLabel, _addressLabel, _hobbiesLabel, _separatorView);
    
    // 水平约束
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[nameLabel]-16-|" options:0 metrics:nil views:views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[ageLabel]-16-|" options:0 metrics:nil views:views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[addressLabel]-16-|" options:0 metrics:nil views:views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[hobbiesLabel]-16-|" options:0 metrics:nil views:views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[separatorView]|" options:0 metrics:nil views:views]];
    
    // 垂直约束
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[nameLabel]-8-[ageLabel]-4-[addressLabel]-4-[hobbiesLabel]-12-[separatorView(0.5)]" options:0 metrics:nil views:views]];
}

#pragma mark - Setter

- (void)setViewModel:(MVVMUserCellViewModel *)viewModel {
    _viewModel = viewModel;
    
    // 根据ViewModel更新UI
    self.nameLabel.text = viewModel.nameText;
    self.ageLabel.text = viewModel.ageText;
    self.addressLabel.text = viewModel.addressText;
    self.hobbiesLabel.text = viewModel.hobbiesText;
}

@end
