//
//  SignalModelTest.m
//  Test
//
//  Created by zhang dekai on 2019/12/20.
//  Copyright © 2019 张德凯. All rights reserved.
//

#import "SignalModelTest.h"

@interface SignalModelTest ()<NSCopying,NSMutableCopying>

@end

/*
 
 单例用处：主要用在封装网络请求，播放器，存放常用数据。
 单例特点：只初始化一次，生命和程序的生命周期相同，访问方便。
 
 */


static SignalModelTest *manager = nil;

@implementation SignalModelTest

//1： GCD once
+(instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
     
    return manager;
}

//2:@synchronized
+(instancetype)shareInstance {
    @synchronized (self) {//加锁 , 防止多线程竞态访问
        if (!manager) {
            manager = [[self alloc]init];
        }
    }
    return manager;
    
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
    });
    return manager;
}

#pragma mark - NSCopying,NSMutableCopying

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return manager;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return manager;
}

@end
