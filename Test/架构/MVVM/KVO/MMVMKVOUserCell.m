#import "MMVMKVOUserCell.h"

@interface MMVMKVOUserCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *ageLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *hobbiesLabel;
@end

@implementation MMVMKVOUserCell

+ (NSString *)reuseIdentifier {
    return @"MMVMKVOUserCell";
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

- (void)setupSubviews {
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont boldSystemFontOfSize:18];
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_nameLabel];
    
    _ageLabel = [[UILabel alloc] init];
    _ageLabel.font = [UIFont systemFontOfSize:14];
    _ageLabel.textColor = [UIColor darkGrayColor];
    _ageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_ageLabel];
    
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.font = [UIFont systemFontOfSize:14];
    _addressLabel.textColor = [UIColor darkGrayColor];
    _addressLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_addressLabel];
    
    _hobbiesLabel = [[UILabel alloc] init];
    _hobbiesLabel.font = [UIFont systemFontOfSize:14];
    _hobbiesLabel.textColor = [UIColor darkGrayColor];
    _hobbiesLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_hobbiesLabel];
}

- (void)setupConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_nameLabel, _ageLabel, _addressLabel, _hobbiesLabel);
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[nameLabel]-16-|" options:0 metrics:nil views:views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[ageLabel]-16-|" options:0 metrics:nil views:views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[addressLabel]-16-|" options:0 metrics:nil views:views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[hobbiesLabel]-16-|" options:0 metrics:nil views:views]];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[nameLabel]-8-[ageLabel]-4-[addressLabel]-4-[hobbiesLabel]-12-|" options:0 metrics:nil views:views]];
}

- (void)setViewModel:(MMVMKVOUserCellViewModel *)viewModel {
    _viewModel = viewModel;
    
    self.nameLabel.text = viewModel.nameText;
    self.ageLabel.text = viewModel.ageText;
    self.addressLabel.text = viewModel.addressText;
    self.hobbiesLabel.text = viewModel.hobbiesText;
}

@end
    
