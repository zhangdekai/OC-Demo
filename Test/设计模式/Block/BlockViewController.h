//
//  BlockViewController.h
//  Test
//
//  Created by zhang dekai on 2019/11/25.
//  Copyright © 2019 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlockViewController : UIViewController

@property (nonatomic, copy)void(^TestBlock)(NSInteger,NSDictionary*);


@end

NS_ASSUME_NONNULL_END
