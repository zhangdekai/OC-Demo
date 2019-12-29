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
    NSLog(@"%s", __func__);
    
    //线程常住 一直处于runloop 保持不崩溃，添加弹窗操作，或者 上传crash 日志
    
    
    
    NSLog(@"$$$ %@",exception);
    
}

void signalHandle(int flag) {
    NSLog(@"%s  flag:%d", __func__, flag);
    
}

@implementation NSExceptionManager


+ (void)getCrash {
    
//    NSSetUncaughtExceptionHandler(<#NSUncaughtExceptionHandler * _Nullable#>)
    
    NSSetUncaughtExceptionHandler(&uncaughtEX);
    
    //信号捕获异常
    signal(SIGHUP, signalHandle);
    
}



@end
