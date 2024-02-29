
//
//  KVOExploreViewController.m
//  Test
//
//  Created by 张德凯 on 2018/7/31.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import "KVOExploreViewController.h"
#import "Person.h"
#import <objc/runtime.h>

/*
 
 NSObject的扩展NSKeyValueObserving
 
 1：Key-Value Observing  “键值监听”,对 NSObject 对象的属性值进行监听。
 KVO（Key-Value Observing）是iOS中一种观察者模式的实现，用于观察对象属性值的变化。当对象的特定属性值发生变化时，注册的观察者会收到通知，并执行相应的操作。
 2：使用方法：
 1. 注册观察者：通过调用被观察对象的 addObserver:forKeyPath:options:context: 方法注册观察者。观察者需要实现 observeValueForKeyPath:ofObject:change:context: 方法来接收属性变化的通知。
 2. 实现观察者方法：在观察者类中实现 observeValueForKeyPath:ofObject:change:context: 方法，根据需要处理属性值的变化。在该方法中，你可以检查属性的变化情况，并采取适当的行动。
 3. 移除观察者：在不需要再观察属性变化时，务必记得调用被观察对象的 removeObserver:forKeyPath: 方法移除观察者，避免内存泄漏和不必要的通知。
 使用 KVO 可以方便地实现对象属性值的观察和响应，但是需要注意内存管理和线程安全等问题，以确保应用程序的稳定性和性能。
 
 总体而言，KVO 的实现是基于 Objective-C Runtime 提供的动态特性，它通过生成子类、重写 setter 方法以及添加观察者和通知机制来实现属性变化的观察。这种机制使得开发者可以轻松地在对象属性发生变化时进行相应的处理，而不需要手动进行检测和通知。
 
 
 */

@interface KVOExploreViewController ()

@end

@implementation KVOExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];

    Person *p1 = [[Person alloc]init];
    Person *p2 = [[Person alloc]init];
    
    p1.age = 1;
    p1.age  = 2;
    
    p2.age = 2;
    
    //打印地址
    NSLog(@"添加KVO监听之前 - p1 = %p, p2 = %p", [p1 methodForSelector: @selector(setAge:)],[p2 methodForSelector: @selector(setAge:)]);
    
    CGFloat ada = 0.23;
    

    ///Users/zhangdekai/Documents/development/flutter
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    
    [p1 addObserver:self forKeyPath:@"age" options:options context:nil];
    
    p1.age = 10;
    
    NSLog(@"添加KVO监听之后 - p1 = %p, p2 = %p", [p1 methodForSelector: @selector(setAge:)],[p2 methodForSelector: @selector(setAge:)]);

    [self printMethod:object_getClass(p2)];
    [self printMethod:object_getClass(p1)];
    
    [p1 willChangeValueForKey:@"age"];
    [p1 didChangeValueForKey:@"age"];

    
    [p1 removeObserver:self forKeyPath:@"age" context:nil];

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
  
    NSLog(@"监听到%@的%@改变了%@", object, keyPath,change);

}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    
    return [super automaticallyNotifiesObserversForKey:key];
}

- (void)printMethod:(Class)cls {
    
    unsigned int count;
    // 获得方法数组
    Method *methodList = class_copyMethodList(cls, &count);
    // 存储方法名
    NSMutableString *methodNames = [NSMutableString string];
    // 遍历所有的方法
    for (int i = 0; i < count; i++) {
        // 获得方法
        Method method = methodList[i];
        // 获得方法名
        NSString *methodName = NSStringFromSelector(method_getName(method));
        // 拼接方法名
        [methodNames appendString:methodName];
        [methodNames appendString:@", "];
    }
    // 释放
    free(methodList);
    // 打印方法名
    NSLog(@"%@ - %@", cls, methodNames);
    
}


@end
