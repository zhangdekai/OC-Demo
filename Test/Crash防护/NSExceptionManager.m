//
//  NSExceptionManager.m
//  Test
//
//  Created by zhang dekai on 2019/12/6.
//  Copyright © 2019 张德凯. All rights reserved.
//

#import "NSExceptionManager.h"

/*
 
 可以用来捕获crash 上传crash 日志
 
 
 */

void uncaughtEX(NSException *exception) {
    
    NSLog(@"大家好，我拦截到了Crash:%@\n", exception);
    
    //线程常住 一直处于runloop 保持不崩溃，添加弹窗操作，或者 上传crash 日志
    
    
    NSDictionary *userInfo = [exception userInfo];
    
    NSLog(@"Exception，Name:%@;\n Reason:%@; \n UserInfo:%@\n",[exception name],[exception reason], userInfo);
    
    
    NSArray *returnAddresses = [exception callStackReturnAddresses];
    
    NSLog(@"Exception returnAddresses is :%@\n",returnAddresses);
    
    
    NSArray *stacks = [exception callStackSymbols];
    
    NSLog(@"Exception callStackSymbols is :%@\n",stacks);
    
}

void signalHandle(int flag) {
    NSLog(@"%s  flag:%d", __func__, flag);
    
}

@implementation NSExceptionManager


+ (void)getCrash {
    
//1:    NSSetUncaughtExceptionHandler(NSUncaughtExceptionHandler * _Nullable)
    
    NSSetUncaughtExceptionHandler(&uncaughtEX);
    
    // 2:信号捕获异常
//    signal(SIGHUP, signalHandle);
    
}



@end
