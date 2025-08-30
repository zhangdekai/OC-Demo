//
//  AppDelegate.m
//  Test
//
//  Created by 张德凯 on 2018/4/14.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "NSExceptionManager.h"
#import <UIKit/UIKit.h>

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "DeviceManager.h"


@interface AppDelegate ()

@property(nonatomic, strong) UITabBarController *tabBarController;


@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [[DeviceManager shareInstance] configDevice:[self hasSafeArea]];

    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [self customTabBarController];
    
    [self.window makeKeyAndVisible];
    

    [NSExceptionManager getCrash];
    
    return YES;
}

- (BOOL)hasSafeArea {
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        NSLog(@"111top == %f", window.safeAreaInsets.top);
        if (window.safeAreaInsets.top > 20) {
            return YES; // 说明有刘海
        }
    }
    
    return NO; // 说明没有刘海
}

/// 配置 UITabBarController
- (UITabBarController *)customTabBarController {
    
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    self.tabBarController = tabBarController;
    
    ViewController *vc = (ViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
    
    vc.tabBarItem.title = @"首页";
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName: [UIFont systemFontOfSize:14]} forState:(UIControlStateNormal)];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor]} forState:(UIControlStateSelected)];

    vc.tabBarItem.image = [[UIImage imageNamed:@"home_clock"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];

    
    FirstViewController *first = [[FirstViewController alloc]init];
    first.tabBarItem.title = @"First";
    
    first.tabBarItem.image = [[UIImage imageNamed:@"home_email"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [first.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName: [UIFont systemFontOfSize:14]} forState:(UIControlStateNormal)];
    [first.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:(UIControlStateSelected)];
    
    
    SecondViewController *second = [[SecondViewController alloc]init];
    second.tabBarItem.title = @"Second";
    second.tabBarItem.image = [[UIImage imageNamed:@"home_yy"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    [second.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:14]} forState:(UIControlStateNormal)];
    [second.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor]} forState:(UIControlStateSelected)];

    
    ThirdViewController *third = [[ThirdViewController alloc]init];
    third.tabBarItem.title = @"Third";
    third.tabBarItem.image = [[UIImage imageNamed:@"home_abc"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [third.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName: [UIFont systemFontOfSize:14]} forState:(UIControlStateNormal)];
    [third.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor]} forState:(UIControlStateSelected)];

    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:first];
    
    UINavigationController *naThird = [[UINavigationController alloc] initWithRootViewController:third];
    
    tabBarController.viewControllers = [NSArray arrayWithObjects:vc,naVC,second,naThird, nil];
    
    
    return tabBarController;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
