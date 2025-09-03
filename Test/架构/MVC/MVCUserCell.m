#import "MVCUserCell.h"

@interface MVCUserCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *ageLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *hobbyLabel;

@end

@implementation MVCUserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - 初始化

- (void)setupSubviews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 姓名标签
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:_nameLabel];
    
    // 年龄标签
    _ageLabel = [[UILabel alloc] init];
    _ageLabel.font = [UIFont systemFontOfSize:14];
    _ageLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:_ageLabel];
    
    // 地址标签
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.font = [UIFont systemFontOfSize:14];
    _addressLabel.textColor = [UIColor grayColor];
    _addressLabel.numberOfLines = 2;
    [self.contentView addSubview:_addressLabel];
    
    // 爱好标签
    _hobbyLabel = [[UILabel alloc] init];
    _hobbyLabel.font = [UIFont systemFontOfSize:14];
    _hobbyLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_hobbyLabel];
}

- (void)setupConstraints {
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _ageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _addressLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _hobbyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        // 姓名标签约束
        [_nameLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:12],
        [_nameLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
        
        // 年龄标签约束
        [_ageLabel.centerYAnchor constraintEqualToAnchor:_nameLabel.centerYAnchor],
        [_ageLabel.leadingAnchor constraintEqualToAnchor:_nameLabel.trailingAnchor constant:12],
        
        // 地址标签约束
        [_addressLabel.topAnchor constraintEqualToAnchor:_nameLabel.bottomAnchor constant:8],
        [_addressLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
        [_addressLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16],
        
        // 爱好标签约束
        [_hobbyLabel.topAnchor constraintEqualToAnchor:_addressLabel.bottomAnchor constant:8],
        [_hobbyLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
        [_hobbyLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16],
        [_hobbyLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-12]
    ]];
}

#pragma mark - 设置数据

- (void)setUser:(MVCUserModel *)user {
    _user = user;
    
    _nameLabel.text = user.name;
    _ageLabel.text = [NSString stringWithFormat:@"%ld岁", (long)user.age];
    _addressLabel.text = [NSString stringWithFormat:@"地址: %@", user.address];
    _hobbyLabel.text = [NSString stringWithFormat:@"爱好: %@", user.hobby];
}

@end
    