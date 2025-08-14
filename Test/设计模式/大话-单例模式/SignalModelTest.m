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


static SignalModelTest *instance = nil;

@implementation SignalModelTest

//1： 方式 1：dispatch_once（推荐，线程安全）
+(instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
     
    return instance;
}

//2:@synchronized
+(instancetype)shareInstance {
    @synchronized (self) {//加锁 , 防止多线程竞态访问
        if (!instance) {
            instance = [[self alloc]init];
        }
    }
    return instance;
    
}

// 3. 重写allocWithZone: 防止通过alloc创建新实例
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

// 重写copyWithZone: 防止通过copy创建新实例
- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return instance;
}

// 重写mutableCopyWithZone:防止通过mutableCopy创建新实例
- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return instance;
}

@end
