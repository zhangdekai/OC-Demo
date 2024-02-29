//
//  NotificationTestViewController.m
//  Test
//
//  Created by zhang dekai on 2024/2/25.
//  Copyright © 2024 张德凯. All rights reserved.
//

/*
 通知模式，也称为 观察者模式，是一种常用的设计模式，它定义了一种一对多的依赖关系，以便一个对象（主题）的状态发生改变时，所有依赖于它的对象（观察者）都能得到通知并自动刷新。
 
 通知模式是一种常用的设计模式，它可以方便地在 iOS中实现组件间通信。在使用通知模式时，需要注意性能开销和内存泄漏问题。


 在 iOS 中，NSNotificationCenter 是实现通知模式的核心类。 它提供了一种机制，允许对象注册对特定通知的监听，并在通知发布时收到通知。

 通知模式的优点：

 降低耦合度： 观察者和主题之间不需要直接耦合，只需要知道对方的通知名称即可。
 提高代码的可维护性： 观察者和主题可以独立开发和维护。
 方便扩展： 可以方便地添加新的观察者或主题。
 
 通知模式的缺点：

 性能开销： 发布通知时，需要遍历所有观察者，可能会造成性能开销。
 内存泄漏： 如果观察者不及时注销，可能会导致内存泄漏。

 
 */

#import "NotificationTestViewController.h"

@interface NotificationTestViewController ()

@end

@implementation NotificationTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testNotificationCenter];
    
}

- (void) testNotificationCenter {
    
    
    NSNotification *notification = [[NSNotification alloc]initWithName:@"user_message" object:nil userInfo:@{@"user_key":@"1223"}];
    
    NSNotificationQueue *queue = [[NSNotificationQueue alloc]init];

    /// 异步的排队发起通知
    [queue enqueueNotification:notification postingStyle:NSPostNow];
    
    
    /// 同步的post
    [[NSNotificationCenter defaultCenter] postNotification:notification];

}


/// add this method to the receive place
- (void)receiveMeessage {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationReceived:) name:@"user_message" object:nil];

}


- (void)notificationReceived:(NSNotification *)notification {
    // 处理通知
    NSLog(@"userInfo == %@", notification.userInfo);

}

// remember remove
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
