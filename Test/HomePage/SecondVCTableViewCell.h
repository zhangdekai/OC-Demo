//
//  SecondVCTableViewCell.h
//  Test
//
//  Created by zhang dekai on 2024/3/10.
//  Copyright © 2024 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDataModel.h"

// 代理处理Cell 的点击事件
// define a delagate
@protocol SecondVCCellActionsDelagate <NSObject>

- (void)handleCommitButtonAction;

- (void)handleAddButtonAction;


@end


typedef void (^VoidBlock)(void);

typedef void (^StringBlock)(NSString * _Nonnull str);


NS_ASSUME_NONNULL_BEGIN

@interface SecondVCTableViewCell : UITableViewCell


- (void)setModel:(CommonDataModel *) model;

@property (nonatomic, copy) VoidBlock commitActionBlock;

// define delegate property
@property (nonatomic, weak) id <SecondVCCellActionsDelagate> delegate;


@end

NS_ASSUME_NONNULL_END
