//
//  TestBlock.m
//  Test
//
//  Created by 张德凯 on 2018/7/16.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import "TestBlock.h"


int age = 10;
static int age1 = 10;

typedef void (^Block)(void);

@implementation TestBlock

- (void)testBlock {
    
    [self test];
    
}

- (void)test{
    
    // xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m 转化为c++

    void(^block)(void) = ^{
        NSLog(@"%@",@"hello");
    };
    block();
    //2019-12-12 12:49:09.132859+0800 Test[1870:38442] <TestBlock: 0x6000014685a0>

    
    NSLog(@"%@",[block class]);
    NSLog(@"%@",[[block class] superclass]);
    NSLog(@"%@",[[[block class] superclass] superclass]);
    NSLog(@"%@",[[[[block class] superclass] superclass]superclass]);

    /*
     2019-12-12 12:49:09.133027+0800 Test[1870:38442] __NSMallocBlock__
     2019-12-12 12:49:09.133140+0800 Test[1870:38442] __NSMallocBlock
     2019-12-12 12:49:09.133246+0800 Test[1870:38442] NSBlock
     2019-12-12 12:49:09.133355+0800 Test[1870:38442] NSObject
     */

    
    
    auto int a1 = 100;
    int age = 10;
    void(^block1)(int,int) = ^ (int a, int b) {
        NSLog(@"this is block,a = %d,b = %d a1= %d",a,b,a1);
        NSLog(@"this is block,age = %d",age);
    };
    block1(3,5);
    
}

- (void)test02 {
    
    __block int age = 10;
    Block block = ^ {
        age = 20;//can fix
        NSLog(@"age is %d",age);//age is 20
    };
    
    block();
}

- (void)test03 {
    
    
    void(^block)(int ,int) = ^(int a, int b){
        NSLog(@"this is block,a = %d,b = %d",a,b);
        NSLog(@"this is block,age = %d",age);
        NSLog(@"this is block,age = %d",age1);
        
    };
    age = 20;
    age1 = 30;
    block(3,5);
}

- (void)test04 {

    // 1. 内部没有调用外部变量的block  __NSGlobalBlock
    void (^block1)(void) = ^{
        NSLog(@"Hello");
    };
    // 2. 内部调用外部变量的block     __NSMallocBlock
    int a = 10;
    void (^block2)(void) = ^{
        NSLog(@"Hello - %d",a);
    };
    // 3. 直接调用的block的class     __NSStackBlock
    NSLog(@"%@ %@ %@", [block1 class], [block2 class], [^{
        NSLog(@"%d",a);
    } class]);
    
    
    
    // Global：没有访问auto变量：__NSGlobalBlock__
    void (^block3)(void) = ^{
        NSLog(@"block1---------");
    };
    // Stack：访问了auto变量： __NSStackBlock__
    int a1 = 10;
    void (^block4)(void) = ^{
        NSLog(@"block2---------%d", a1);
    };
    NSLog(@"%@ %@", [block3 class], [block2 class]);
    // __NSStackBlock__调用copy ： __NSMallocBlock__
    NSLog(@"%@", [[block4 copy] class]);
    
}





- (instancetype)initWithName:(NSString *)name
{
    if (self = [super init]) {
        self.name = name;
        
        
        NSMutableArray *array = [NSMutableArray array];
        __block int asd =  5;
        void (^Block)(void) = ^{
            [array addObject:@"1"];
            [array addObject:@"2"];
            asd = 10;
            NSLog(@"%@  /n %d",array,asd);
        };
        Block();
        
        
        int a = 10;
        NSObject *b = [[NSObject alloc]init];
        char c = '1dwsdq';
        char *d = 'c';

        NSLog(@"sizeof(int):%lu",sizeof(a));
        NSLog(@"sizeof(*):%lu",sizeof(b));
        NSLog(@"sizeof(*):%lu",sizeof(c));
        NSLog(@"sizeof(*):%lu",sizeof(d));
//        NSLog(@"sizeof(*):%lu",malloc_size((__bridge const void *)b));
        
        
    }
    return self;
}
+ (void) test2
{
    NSLog(@"类方法test2");
}

- (void)test01 {
    

    
    int number = 20;
    __block int age = 10;
    
    TestBlock *object = [[TestBlock alloc] init];
    __block  TestBlock *object1 = [[TestBlock alloc] init];
    
    __weak TestBlock *weakObj = object;
    
    TestBlock *p = [[TestBlock alloc] init];
    __block TestBlock *person = p;
    __block __weak TestBlock *weakPerson = p;
    
    Block block = ^ {
        
        NSLog(@"%d",number); // 局部变量
        NSLog(@"%d",age); // __block修饰的局部变量
        NSLog(@"%p",object); // 对象类型的局部变量
        NSLog(@"%p",object1);
        NSLog(@"%p",weakObj); // __weak修饰的对象类型的局部变量
        NSLog(@"%p",person); // __block修饰的对象类型的局部变量
        NSLog(@"%p",weakPerson); // __block，__weak修饰的对象类型的局部变量
    };
    block();
    
}

@end
