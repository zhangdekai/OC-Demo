
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
 
 键值观察：
 
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
