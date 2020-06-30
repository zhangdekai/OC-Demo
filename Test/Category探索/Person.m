//
//  Person.m
//  Test
//
//  Created by 张德凯 on 2018/7/31.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (void)load
{
    NSLog(@"i am Person load");
}


-(void)setAge:(NSInteger)age {
    NSLog(@"setAge:");
    _age = age;
}

- (void)run
{
    NSLog(@"Person - run");
}



//KVO
- (void)willChangeValueForKey:(NSString *)key
{
    
    NSLog(@"willChangeValueForKey: - begin");
    [super willChangeValueForKey:key];
    NSLog(@"willChangeValueForKey: - end");
}

- (void)didChangeValueForKey:(NSString *)key
{
    NSLog(@"didChangeValueForKey: - begin");
    [super didChangeValueForKey:key];//didChangeValueForKey方法内部又会调用监听器的observeValueForKeyPath:ofObject:change:context:监听方法
    NSLog(@"didChangeValueForKey: - end");
}


- (void)dealloc {
    NSLog(@"person 被释放了呢");
}



@end
