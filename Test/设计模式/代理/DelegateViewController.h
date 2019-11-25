//
//  DelegateViewController.h
//  Test
//
//  Created by zhang dekai on 2019/11/25.
//  Copyright © 2019 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TestDelegate <NSObject>

- (void)testDelegate;

@end

@interface DelegateViewController : UIViewController

@property(nonatomic, weak)UILabel *label1;

@property(nonatomic, weak)id<TestDelegate> delegate;



@end

NS_ASSUME_NONNULL_END
