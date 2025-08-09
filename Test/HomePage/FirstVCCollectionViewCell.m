//
//  FirstVCCollectionViewCell.m
//  Test
//
//  Created by zhang dekai on 2024/3/10.
//  Copyright © 2024 张德凯. All rights reserved.
//

#import "FirstVCCollectionViewCell.h"


#warning - xib 记得必要时 去掉safeArea

@interface FirstVCCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;


@end

@implementation FirstVCCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentView.layer.cornerRadius = 4;
    self.contentView.layer.borderWidth = 0.5;
    self.contentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    
}

- (void)setCellModel:(CommonDataModel*) model{
    
    _titleLable.text = model.title;
    _subTitleLabel.text = model.subTitle;
    _desLabel.text = model.descrip;
    [_uploadButton setTitle:@"Test" forState:(UIControlStateNormal)];
    [_uploadButton setEnabled:false];
}

@end
