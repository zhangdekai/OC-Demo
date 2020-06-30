//
//  TestBridgeViewController.m
//  Test
//
//  Created by zhang dekai on 2019/12/15.
//  Copyright © 2019 张德凯. All rights reserved.
//

#import "TestBridgeViewController.h"
#import <CoreFoundation/CoreFoundation.h>

/*
 
 iOS __bridge那些事: https://www.jianshu.com/p/5fbe5478e24b
 
 
 */

@interface TestBridgeViewController ()

@end

@implementation TestBridgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self test01];
    
    [self OCToVoid__bridge_retainedInARC];
    
    [self VoidToOC__bridge_transferInARC];
    
    [self CoreFoundationToOC__bridge];
    
    [self CoreFoundationToOC__bridge_transferAndCFBridgingRelease];
    
    [self OCToCoreFoundation__bridge];
    
}
#pragma mark OC指针与void *互相转换，使用 __bridge,不改变持有情况
- (void)test01 {
    
    id obj = [[NSObject alloc]init];
    
    void *p = (__bridge void*)obj;//OC转C
    
    NSLog(@"%@",p);
    
    id o = (__bridge id)(p);;//C转OC;此时指针变量 p 并没有持有对象，因为__bridge并不会改变持有情况
    
    NSLog(@"%@",o);
    
}

#pragma mark - OC指针转换为void *指针，ARC下使用 __bridge_retained

- (void)OCToVoid__bridge_retainedInARC {
    
    void *p = 0;
    
    {
        id obj = [[NSObject alloc]init];
        
        //        p = (__bridge void *)obj; 报错，obj出了作用域就会销毁，__bridge不改变持有情况，所以p成为悬垂指针
//        p = (__bridge void*)obj;
        
        p = (__bridge_retained void*)obj;//之后p持有对象

    }//出了作用域 obj 释放了
    
    NSLog(@"class===%@",[(__bridge id)p class]);

}
#pragma mark - void *指针转换为OC指针，ARC下使用 __bridge_transfer

- (void)VoidToOC__bridge_transferInARC {
    
    void *p = 0;
    
    {
        id tempObj = [[NSObject alloc] init];
        //(__bridge_retained <#CF type#>)<#expression#>)
        p = (__bridge_retained void *)tempObj;
    }
    
    id obj = (__bridge_transfer id)p;//p没有被释放呢？obj为强类型，不释放。
    
    
    NSLog(@"class===%@",obj);
    
    NSLog(@"class===%@",p);


}

#pragma mark - 将Core Foundation的对象转换为OC对象来处理，使用 __bridge

static __weak id testPointer = nil;
static id testPointer1 = nil;

- (void)CoreFoundationToOC__bridge {
    
    // 创建一个作用域，目的是测试Core Foundation框架的对象会不会在作用结束后自动回收
    {
        /**
         
         CFMutableArrayRef是CF框架下的类型，编译器无法自动管理内存，也就是说系统不会主动释放CFMutableArrayRef的变量，不手动释放就会内存泄露

         Core Foundation框架生成并持有对象，之后的对象引用计数为“1”。
         
         */
        CFMutableArrayRef cfMutableArr = CFArrayCreateMutable(kCFAllocatorDefault, 0, NULL);
        
        // __bridge转换不改变对象的持有情况
        testPointer = (__bridge id)cfMutableArr;//被转化为了NSMutableArray
        
//        testPointer1 = (__bridge_transfer id)cfMutableArr;//转化赋值给强类型对象，cfMutableArr不释放。
        
        // testPointer = CFBridgingRelease(cfMutableArr); 报错,因为CFBridgingRelease()会立即释放cfMutableArr，弱指针立即置为nil
        
        // 作用域内打印引用计数
        CFIndex count = CFGetRetainCount(cfMutableArr);
        NSLog(@"count===%ld",count);// count===1
    }
    
    /**
     作用域外打印仍然是1，可见作用域结束后并不能销毁Core Foundation框架的对象，发生内存泄漏
     */
    CFMutableArrayRef cfTemp = (__bridge CFMutableArrayRef)testPointer;
    CFIndex count2 = CFGetRetainCount(cfTemp);
    NSLog(@"count2===%ld",count2);// count2===1
    
    
    /**
     方法作用域外打印引用计数
     */
    [self printOutOfMethodScope];
}

// MARK:方法作用域外打印引用计数
- (void)printOutOfMethodScope {
    /**
     虽然count3显示是2，但是只要调用CFRelease释放一次，CFGetRetainCount()就会崩溃，因为实际上RetainCount是1，所以这应该是个系统bug😊
     
     CFIndex count3 = CFGetRetainCount((__bridge CFMutableArrayRef)(testPointer));
     CFRelease((__bridge CFMutableArrayRef)testPointer);
     
     NSLog(@"count3===%ld",count3);// count3===2
     NSLog(@"count4===%ld",CFGetRetainCount((__bridge CFMutableArrayRef)(testPointer)));// 崩溃
     */
    
    // 在方法作用域外打印引用计数仍然是“1”，可见cfMutableArr如不妥善管理，极易造成内存泄露
    CFMutableArrayRef cfTemp = (__bridge CFMutableArrayRef)testPointer;
    CFIndex count3 = CFGetRetainCount(cfTemp);
    NSLog(@"count3===%ld",count3);// count3===1
}

#pragma mark - 将Core Foundation的对象转换为OC对象来处理，使用CFBridgingRelease或__bridge_transfer

static __weak id testPointer2 = nil;

- (void)CoreFoundationToOC__bridge_transferAndCFBridgingRelease {
    
    {
        CFMutableArrayRef cfMutableArray = CFArrayCreateMutable(kCFAllocatorDefault, 0, NULL);
        
        /**
         *Core Foundation框架的API生成并持有对象，之后的对象引用计数为“1”。
         */
        NSLog(@"RetainCount===%ld",CFGetRetainCount(cfMutableArray));// RetainCount===1
        
        /**
         *通过CFBridgingRelease赋值，变量obj持有对象强引用的同时，cfMutableArray指针对于对象的强引用通过CFBridgingRelease释放。
         */
         id obj = CFBridgingRelease(cfMutableArray); // 或者id obj = (__bridge_transfer id)cfMutableArray;
        
        // 用testPointer2这个弱指针来跟踪obj，在出了作用域后最终是否被释放
        testPointer2 = obj;
        NSLog(@"weak===%@",testPointer2); // weak===( )
        
        // 因为只有obj持有对象的强引用，故引用计数为“1”。
        NSLog(@"RetainCount after the cast===%ld",CFGetRetainCount(cfMutableArray));// RetainCount after the cast===1
        
        // 另外，因为经由CFBridgingRelease转换后，赋值给cfMutableArray中的指针也指向仍然存在的对象，所以可以正常使用。
        NSLog(@"class===%@",[obj class]);// class===__NSCFArray
    }
    
    // 出了作用域后obj就立即被释放了，所以弱指针testPointer2才会为nil
    NSLog(@"weak after the cast===%@",testPointer2);// weak after the cast===(null)
}

#pragma mark - 将OC对象转换为Core Foundation的对象来处理，使用 __bridge

- (void)OCToCoreFoundation__bridge {
    CFMutableArrayRef cfMutableArr = NULL;
    {
        // 变量obj持有对生成对象并持有对象的强引用
        id obj = [[NSMutableArray alloc] init];
        
        /**
         *因为__bridge转换不改变对象的持有状况，
         *所以只有通过变量obj的强引用，
         *引用计数为“1”。
         */
        cfMutableArr = (__bridge CFMutableArrayRef)obj;
        CFShow(cfMutableArr);
        NSLog(@"RetainCount===%ld",CFGetRetainCount(cfMutableArr));
    }
    /**
     * 因为变量obj超出其作用域，
     * 所以其强引用失效，对象得到释放，
     * 无持有者的对象被废弃。
     */
    
    
    /**
     * 此后对对象的访问出错！（悬垂指针）
     */
    NSLog(@"RetainCount after the scope===%ld",CFGetRetainCount(cfMutableArr));
    CFRelease(cfMutableArr);
}

#pragma mark - 将OC对象转换为Core Foundation的对象来处理，使用CFBridgingRetain或__bridge_retained

- (void)OCToCoreFoundation__bridge_retainedAndCFBridgingRetain {
    
    CFMutableArrayRef cfMutableArr = NULL;
    {
        // 变量obj持有对生成对象并持有对象的强引用
        id obj = [[NSMutableArray alloc] init];
        
        /**
         *通过CFBridgingRetain或者__bridge_retained，
         *将对象CFRetain，
         *赋值给变量cfMutableArr
         */
        cfMutableArr = (__bridge_retained CFMutableArrayRef)obj;// 或者CFBridgingRetain(obj)
        
        /**
         * 通过obj的强引用和
         * 通过__bridge_retained，
         * 引用计数为“2”
         */
        CFShow(cfMutableArr);
        NSLog(@"RetainCount===%ld",CFGetRetainCount(cfMutableArr)); // RetainCount===2
    }
    /**
     * 因为变量obj超出其作用域，所以其强引用失效，
     * 引用计数为“1”
     */
    NSLog(@"RetainCount after the scope===%ld",CFGetRetainCount(cfMutableArr));
    
    CFRelease(cfMutableArr);
    /**
     * 因为将对象CFRelease，所以其引用计数为“0”
     * 故该对象被废弃。
     */
}

@end
