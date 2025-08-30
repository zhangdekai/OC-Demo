//
//  CADisplayLinkTest.h
//  Test
//
//  Created by zhang dekai on 2025/8/28.
//  Copyright © 2025 张德凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CADisplayLinkTest : UIViewController

@property (nonatomic, strong) UIView *ball;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat speed;   // 每秒移动多少像素
@property (nonatomic, assign) CFTimeInterval lastTimestamp; // 上一帧的时间


@end

NS_ASSUME_NONNULL_END
