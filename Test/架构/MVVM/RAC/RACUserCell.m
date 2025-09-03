#import "RACUserCell.h"
#import "RACUserCellViewModel.h"

@interface RACUserCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *ageLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *hobbiesLabel;

@end

@implementation RACUserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - 初始化子视图

- (void)setupSubviews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 姓名标签
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _nameLabel.font = [UIFont boldSystemFontOfSize:18];
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
    _hobbiesLabel.numberOfLines = 0; // 多行显示
    [self.contentView addSubview:_hobbiesLabel];
}

- (void)setupConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_nameLabel, _ageLabel, _addressLabel, _hobbiesLabel);
    
    [NSLayoutConstraint activateConstraints:@[
        // 姓名标签约束
        [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:12],
        [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:16],
        [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-16],
        
        // 年龄标签约束
        [NSLayoutConstraint constraintWithItem:self.ageLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:8],
        [NSLayoutConstraint constraintWithItem:self.ageLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:self.ageLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0],
        
        // 地址标签约束
        [NSLayoutConstraint constraintWithItem:self.addressLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.ageLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:4],
        [NSLayoutConstraint constraintWithItem:self.addressLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:self.addressLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0],
        
        // 爱好标签约束
        [NSLayoutConstraint constraintWithItem:self.hobbiesLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.addressLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:4],
        [NSLayoutConstraint constraintWithItem:self.hobbiesLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:self.hobbiesLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:self.hobbiesLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-12]
    ]];
}

#pragma mark - Setter方法

- (void)setViewModel:(RACUserCellViewModel *)viewModel {
    _viewModel = viewModel;
    
    // 根据ViewModel更新UI
    self.nameLabel.text = viewModel.nameText;
    self.ageLabel.text = viewModel.ageText;
    self.addressLabel.text = viewModel.addressText;
    self.hobbiesLabel.text = viewModel.hobbiesText;
}

@end
