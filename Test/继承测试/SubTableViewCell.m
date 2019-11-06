//
//  SubTableViewCell.m
//  Test
//
//  Created by 张德凯 on 2018/5/17.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import "SubTableViewCell.h"

@implementation SubTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)handView:(NSString *)str {
    NSLog(@"我是 子View");
}

@end
