//
//  CADisplayLinkTest.m
//  Test
//
//  Created by zhang dekai on 2025/8/28.
//  Copyright © 2025 张德凯. All rights reserved.
//

#import "CADisplayLinkTest.h"

/// CADisplayLink 是 iOS 提供的一种定时器类，属于 Core Animation 框架。它的特点是会和 屏幕刷新率同步回调，因此非常适合需要和屏幕绘制保持一致的场景。


/// CADisplayLink 驱动小球移动 动画
@implementation CADisplayLinkTest

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 1. 创建一个小球
    self.ball = [[UIView alloc] initWithFrame:CGRectMake(50, 200, 50, 50)];
    self.ball.backgroundColor = [UIColor systemBlueColor];
    self.ball.layer.cornerRadius = 25;
    [self.view addSubview:self.ball];
    
    // 2. 设置速度（像素/秒）
    self.speed = 100.0;
    
    // 3. 创建 CADisplayLink
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateFrame:)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateFrame:(CADisplayLink *)link {
    if (self.lastTimestamp == 0) {
        self.lastTimestamp = link.timestamp;
        return;
    }
    
    // 计算时间差（上一帧 -> 当前帧）
    CFTimeInterval delta = link.timestamp - self.lastTimestamp;
    self.lastTimestamp = link.timestamp;
    
    // 根据时间差计算位置（保证不同设备帧率下速度一致）
    CGFloat distance = self.speed * delta;
    self.ball.center = CGPointMake(self.ball.center.x + distance, self.ball.center.y);
    
    // 如果移动到屏幕外就停止
    if (self.ball.frame.origin.x > self.view.bounds.size.width) {
        [self.displayLink invalidate];
        self.displayLink = nil;
        NSLog(@"动画结束");
    }
}

@end

