//
//  ReflectionClass.m
//  Test
//
//  Created by zhang dekai on 2025/8/11.
//  Copyright © 2025 张德凯. All rights reserved.
//

#import "ReflectionClass.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation ReflectionClass

/*
 你说的这个 “反射技术去除 if 语句”，其实是一种结合 反射（Reflection）+ 工厂模式 或 策略模式 的动态对象创建方式。
 核心思想是：
 
 把“根据条件判断创建不同对象”的 if-else / switch 逻辑转移到类映射表或运行时动态查找中，让代码更灵活、可扩展。
 
 //Objective-C 支持 类名字符串转类对象（Class）：
 
 反射技术去除 if-else 的本质是：

 用数据（类名、映射表）替代逻辑判断。

 利用运行时动态创建对象。

 通常配合工厂模式、策略模式使用。

 优点：

 易扩展，符合开闭原则。

 代码更简洁。

 缺点：

 依赖字符串，拼写错误可能导致崩溃。

 反射比直接 new 对象略慢，但在 UI 或业务代码中差异可忽略。
 
 */

// 传统写法：
-(id)commonMethod:(NSString *)type {
    id obj = nil;
    if ([type isEqualToString:@"Button"]) {
        obj = [[UIButton alloc] init];
    } else if ([type isEqualToString:@"Label"]) {
        obj = [[UILabel alloc] init];
    } else if ([type isEqualToString:@"ImageView"]) {
        obj = [[UIImageView alloc] init];
    }
    return obj;
}


- (id)createUIComponent:(NSString *)className {
    //Objective-C 支持 类名字符串转类对象（Class）：
    Class cls = NSClassFromString(className);
    if (cls) {
        return [[cls alloc] init];
    }
    return nil;
}

- (void)test{
    
    // 使用
    id button = [self createUIComponent:@"UIButton"];
    id label = [self createUIComponent:@"UILabel"];
    
}

@end


/*
 方式 2：结合注册表（更安全）
 如果直接用字符串创建类，有可能拼错导致崩溃，因此可以注册映射表：
 */
@interface UIComponentFactory : NSObject

@property (nonatomic, strong) NSDictionary *classMap;

+ (instancetype)sharedFactory;

- (id)createComponent:(NSString *)key;

@end

@implementation UIComponentFactory
+ (instancetype)sharedFactory {
    static UIComponentFactory *factory;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        factory = [[UIComponentFactory alloc] init];
        factory.classMap = @{
            @"Button": @"UIButton",
            @"Label": @"UILabel",
            @"ImageView": @"UIImageView"
        };
    });
    return factory;
}

- (id)createComponent:(NSString *)key {
    NSString *className = self.classMap[key];
    Class cls = NSClassFromString(className);
    return cls ? [[cls alloc] init] : nil;
}

-(void)test{
    // 使用
    id btn = [[UIComponentFactory sharedFactory] createComponent:@"Button"];
    id lbl = [[UIComponentFactory sharedFactory] createComponent:@"Label"];

}

@end

