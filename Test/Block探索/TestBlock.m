//
//  TestBlock.m
//  Test
//
//  Created by 张德凯 on 2018/7/16.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import "TestBlock.h"
#import "Person.h"
#import "NSObject+tools.h"

//#define WS(weakSelf) __weak typeof(&*self) weakSelf = self;

#define  TSWeakSelf __weak typeof(self)weakSelf = self;


int age = 10;
static int age1 = 10;

typedef void (^Block)(void);

@interface TestBlock ()

@property (nonatomic, strong) Person *person001;


@end



@implementation TestBlock

- (void)testBlock {
    
    
    
//    __weak typeof(self) weakSelf = self;
    
//    self.person001 = [Person alloc];
    
    
    
//    [self test];
//    [self test05];
    [self test06];

    
}

- (void)test06 {
    
    Person *person = [[Person alloc]init];
    
    __weak Person *weakP = person;
    
    
    NSLog(@"引用计数:%ld", [person retainCount1]);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        NSLog(@"weakP 引用计数:%ld", [weakP retainCount1]);

        __strong Person *strongP = weakP;
        
        NSLog(@"当前线程：%@",[NSThread currentThread]);
        //3秒后——(null)
        //此处的weakP 是弱引用，block内部也是弱引用的 引用计数不变化;person对象没有强指针引用就会被释放
        NSLog(@"3秒后——weakP=%@",weakP);
        
        NSLog(@"3秒后——strongP=%@",person);//调用了self.person 强引用

    });
    NSLog(@"dispatch_after调用结束");
    NSLog(@"---引用计数:%ld", [person retainCount1]);
    // 实例对象person 在此处弱引用了，出了此 }(作用域)就被释放了呢
}

- (void)test05 {
    
    Person *person = [[Person alloc]init];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //3秒后——<Person: 0x600003c28ce0>
        //此处的person 是强引用，block内部也是强引用的 引用计数+1，person被copy到堆上了
        NSLog(@"3秒后——person = %@",person);
    });
    NSLog(@"dispatch_after调用结束");
}


- (void)test{
    
    // xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m 转化为c++

    TSWeakSelf;
    
    int bb = 10;
    void(^block)(void) = ^{
        NSLog(@"%@",@"hello");
        NSLog(@"%d",bb);
        weakSelf.count = 100;
    };
    block();

    
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
+ (void) test2 {
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
    /* 转化为C++
    struct __main_block_impl_0 {
      struct __block_impl impl;
      struct __main_block_desc_0* Desc;
      
      int number;
      NSObject *__strong object;
      NSObject *__weak weakObj;
      __Block_byref_age_0 *age; // by ref
      __Block_byref_person_1 *person; // by ref
      __Block_byref_weakPerson_2 *weakPerson; // by ref
      
      __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _number, NSObject *__strong _object, NSObject *__weak _weakObj, __Block_byref_age_0 *_age, __Block_byref_person_1 *_person, __Block_byref_weakPerson_2 *_weakPerson, int flags=0) : number(_number), object(_object), weakObj(_weakObj), age(_age->__forwarding), person(_person->__forwarding), weakPerson(_weakPerson->__forwarding) {
     
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
      }
    };
    
     */
}


@end
