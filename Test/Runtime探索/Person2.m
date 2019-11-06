//
//  Person2.m
//  Test
//
//  Created by 张德凯 on 2018/8/13.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import "Person2.h"
#import <objc/runtime.h>
#import "Car.h"

struct method_t {
    SEL sel;
    char *types;
    IMP imp;
};

@implementation Person2

- (void)other
{
    NSLog(@"%s",__func__);
}

void cook(id self, SEL _cmd,id Num)//方法有问题
{
    // 实现内容
    NSLog(@"%@的%@方法动态实现了,参数为%@",self,NSStringFromSelector(_cmd),Num);
}

// 方法调用 之 2：动态解析方法 阶段
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    
    if (sel == @selector(test)) {
        
        Method otherMethod = class_getInstanceMethod(self, @selector(other));
        
//        struct method_t *method = (struct method_t *)class_getInstanceMethod(self, @selector(other));
        
//        NSLog(@"%s,%p,%s",method->sel,method->imp,method->types);

        /**
         // 动态添加test方法的实现
         
         第一个参数： cls:给哪个类添加方法
         第二个参数： SEL name:添加方法的名称
         第三个参数： IMP imp: 方法的实现，函数入口，函数名可与方法名不同（建议与方法名相同）
         第四个参数： types :方法类型，需要用特定符号，参考API
         */
        
        class_addMethod(self, sel, method_getImplementation(otherMethod), method_getTypeEncoding(otherMethod));
        
        // 返回YES表示有动态添加方法

        return YES;
    } else if (sel == @selector(eat:)) {
        
        class_addMethod(self, sel, (IMP)cook, "v@:@");
        
        return YES;
    }
    
    NSLog(@"%s",__func__);
    
    return [super resolveInstanceMethod:sel];
    
}

// 方法调用 之 2：动态解析方法 阶段
+ (BOOL)resolveClassMethod:(SEL)sel
{
    
    return [super resolveClassMethod:sel];
}

// 方法调用 之 3：消息转发 阶段  最后一个阶段

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if (aSelector == @selector(driving)) {
        // 返回能够处理消息的对象
//        return [[Car alloc]init];
        
        // 返回nil则会调用methodSignatureForSelector方法
        return nil;
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

// 方法签名：返回值类型、参数类型
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if (aSelector == @selector(driving)) {
        
        // return [NSMethodSignature signatureWithObjCTypes: "v@:"];
        // return [NSMethodSignature signatureWithObjCTypes: "v16@0:8"];
        // 也可以通过调用Car的methodSignatureForSelector方法得到方法签名，这种方式需要car对象有aSelector方法
        return [[[Car alloc]init]methodSignatureForSelector:aSelector];
    } else if (aSelector == @selector(driving1:)) {
        return [NSMethodSignature signatureWithObjCTypes:"i@:i"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

//NSInvocation 封装了一个方法调用，包括：方法调用者，方法，方法的参数
//    anInvocation.target 方法调用者
//    anInvocation.selector 方法名
//    [anInvocation getArgument: NULL atIndex: 0]; 获得参数
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    //   anInvocation中封装了methodSignatureForSelector函数中返回的方法。
    //   此时anInvocation.target 还是person对象，我们需要修改target为可以执行方法的方法调用者。
    //   anInvocation.target = [[Car alloc] init];
    //   [anInvocation invoke];
    
//    [anInvocation invokeWithTarget:[[Car alloc]init]];
    
    
    int time;
    // 获取方法的参数，方法默认还有self和cmd两个参数，因此新添加的参数下标为2
    [anInvocation getArgument:&time atIndex:2];
    NSLog(@"修改前参数的值 = %d",time);
    
    time += 10;
    
    NSLog(@"修改后的值 = %d",time);
    
    // 设置方法的参数 此时将参数设置为110
    [anInvocation setArgument:&time atIndex:2];
    // 将tagert设置为Car实例对象
    [anInvocation invokeWithTarget:[[Car alloc]init]];
    
    int result;
    [anInvocation getReturnValue:&result];
    NSLog(@"获取方法的返回值 = %d",result);//是否变为 2 * time ？
    
    result = 99;
    // 设置方法的返回值 重新将返回值设置为99
    [anInvocation setReturnValue:&result];
    
    // 获取方法的返回值
    [anInvocation getReturnValue:&result];
    NSLog(@"修改方法的返回值为 = %d",result);    // result = 99

    /*
     
     只要来到forwardInvocation方法中，我们便对方法调用有了绝对的掌控权，可以选择是否调用方法，以及修改方法的参数返回值等等。
     
     */
}

/*
 当类对象进行消息转发时，对调用相应的+号的forwardingTargetForSelector、methodSignatureForSelector、forwardInvocation方法，需要注意的是+号方法仅仅没有提示，而不是系统不会对类方法进行消息转发。
 */
+ (id)forwardingTargetForSelector:(SEL)aSelector
{
    if (aSelector == @selector(driving2)) {
//        return [Car class];
        return nil;

    }
    return [super forwardingTargetForSelector:aSelector];
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if (aSelector == @selector(driving2)) {
        
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation
{
    [anInvocation invokeWithTarget:[Car class]];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    NSLog(@"%@没有找到实现方法哦，你个笨蛋，没实现啊！！！", NSStringFromSelector(aSelector));
}

+ (void)doesNotRecognizeSelector:(SEL)aSelector
{
    NSLog(@"%@没有找到实现方法哦，你个笨蛋，没实现啊！！！", NSStringFromSelector(aSelector));
}

@end
