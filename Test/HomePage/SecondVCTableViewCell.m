//
//  SecondVCTableViewCell.m
//  Test
//
//  Created by zhang dekai on 2024/3/10.
//  Copyright © 2024 张德凯. All rights reserved.
//

#import "SecondVCTableViewCell.h"


@interface SecondVCTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UIButton *bottomButton;
@property (nonatomic, strong) UIButton *addButton;


@end


@implementation SecondVCTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    

    
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(self){
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 200, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        
        
        self.subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 45, 200, 20)];
        _subTitleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
        _subTitleLabel.textColor = [UIColor blackColor];
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_subTitleLabel];
        
        
        self.desLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 75, 200, 20)];
        _desLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
        _desLabel.textColor = [UIColor grayColor];
        _desLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_desLabel];
    
        
        
        self.bottomButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 100, 70, 35)];
        
        [_bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        [_bottomButton setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:1.0 alpha:0.5]];
        [_bottomButton setTitle:@"提交" forState:UIControlStateNormal];
        [_bottomButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_bottomButton];
        
        
        
        self.addButton = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenWidth - 85, 100, 70, 35)];
        
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        [_addButton setBackgroundColor:[UIColor colorWithRed:0 green:0.5 blue:0 alpha:0.5]];
        [_addButton setTitle:@"+" forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(buttonAddClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_addButton];
        
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 145, UIScreenWidth, 0.5)];
        line.backgroundColor = [UIColor linkColor];
        [self.contentView addSubview:line];
    
        
    }
    
    return self;
    
}

- (void)setModel:(SecondVCModdel *) model{
    
    _titleLabel.text = model.title;
    _subTitleLabel.text = model.subTitle;
    _desLabel.text = model.descrip;
    
}


- (void)buttonClick:(UIButton *)button {
    
    NSLog(@"提交 action");
    
    if(self.commitActionBlock != nil){
        _commitActionBlock();
    }
    
    [self.delegate handleCommitButtonAction];
    
}

- (void)buttonAddClick:(UIButton *)button{
    
    NSLog(@"Add button action");

    [self.delegate handleAddButtonAction];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
