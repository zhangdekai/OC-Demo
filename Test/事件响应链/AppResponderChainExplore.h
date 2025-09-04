//
//  AppResponderChainExplore.h
//  Test
//
//  Created by zhang dekai on 2025/9/4.
//  Copyright © 2025 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppResponderChainExplore : UIView

@end

NS_ASSUME_NONNULL_END

/*
 1. 事件产生
 当用户点击屏幕时，硬件层面会检测到触摸动作并将其转化为电信号，通过 IOKit 框架传递给系统内核。
 
 2. 事件传递
 内核会将事件包装成UIEvent对象，并通过mach port传递给 SpringBoard 进程，再由它分发给当前活跃的应用程序。
 
 3. 事件响应链建立
 应用程序的UIApplication对象接收到事件后，会将其传递给UIWindow对象，然后开始寻找最合适的响应者：
 
 */
