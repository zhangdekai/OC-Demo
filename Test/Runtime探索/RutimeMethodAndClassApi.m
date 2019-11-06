
//
//  RutimeMethodAndClassApi.m
//  Test
//
//  Created by 张德凯 on 2018/8/17.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import "RutimeMethodAndClassApi.h"
#import "Car.h"
#import <objc/runtime.h>

@implementation RutimeMethodAndClassApi

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /*
         
         6.用于判断一个OC对象是否为Class
         
         Student1 *student = [[Student1 alloc]init];
         
         NSLog(@"%d",object_isClass(student));// 0
         NSLog(@"%d",object_isClass([Student1 class]));// 1
         NSLog(@"%d",object_isClass(object_getClass([Person1 class])));// 1 // 元类对象也是特殊的类对象
         
         */
        
        /*
         5.设置isa指向的Class，可以动态的修改类型。例如修改了person对象的类型，也就是说修改了person对象的isa指针的指向，中途让对象去调用其他类的同名方法。
         
         Student1 *student = [[Student1 alloc]init];
         [student driving];
         object_setClass(student, [Car class]);
         [student driving];//最终其实调用了Car的run方法
         
         */
        
        /*
         
         4.获取isa指向的Class，若将类对象传入获取的就是元类对象，若是实例对象则为类对象
         
         Person1 *person = [[Person1 alloc]init];
         
         object_getClass(person);//获取类对象
         [Person1 class];//获取类对象
         object_getClass([Person1 class]);//最终获取元类对象
         //     打印内容
         //    Runtime应用[21115:3807804] 0x100001298,0x100001298,0x100001270
         NSLog(@"%p,%p,%p",object_getClass(person), [Person1 class],
         object_getClass([Person1 class]));
         
         */
        
        //    Person1 *p1 = [[Person1 alloc]init];
        //    p1.tall = YES;
        //    p1.rich = NO;
        //    p1.handsome = YES;
        //    NSLog(@"Tall : %d  Rich : %d Handsome ： %d",p1.tall,p1.rich,p1.handsome);
        
        //    Person2 *p2 = [[Person2 alloc]init];
        //    [p2 test];
        //    [p2 eat:10];
        //    [p2 driving];
        //    NSLog(@"[person driving: 100] = %d",[p2 driving1: 100]);
        //    [Person2 driving2];
        //    [p2 driving3];
        //    [Person2 driving4];
        
        //    Student1 *student = [[Student1 alloc]init];
        //    student.tall = YES;
        
    }
    return self;
}


void run(id self, SEL _cmd)
{
    NSLog(@"%@ - %@", self,NSStringFromSelector(_cmd));
}
//方法相关API
int someMethodsAboutRuntimeAPI()
{
    /*
     
     1. 获得一个实例方法、类方法
     Method class_getInstanceMethod(Class cls, SEL name)
     Method class_getClassMethod(Class cls, SEL name)
     
     2. 方法实现相关操作
     IMP class_getMethodImplementation(Class cls, SEL name)
     IMP method_setImplementation(Method m, IMP imp)
     void method_exchangeImplementations(Method m1, Method m2)
     
     3. 拷贝方法列表（最后需要调用free释放）
     Method *class_copyMethodList(Class cls, unsigned int *outCount)
     
     4. 动态添加方法
     BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types)
     
     5. 动态替换方法
     IMP class_replaceMethod(Class cls, SEL name, IMP imp, const char *types)
     
     6. 获取方法的相关信息（带有copy的需要调用free去释放）
     SEL method_getName(Method m)
     IMP method_getImplementation(Method m)
     const char *method_getTypeEncoding(Method m)
     unsigned int method_getNumberOfArguments(Method m)
     char *method_copyReturnType(Method m)
     char *method_copyArgumentType(Method m, unsigned int index)
     
     7. 选择器相关
     const char *sel_getName(SEL sel)
     SEL sel_registerName(const char *str)
     
     8. 用block作为方法实现
     IMP imp_implementationWithBlock(id block)
     id imp_getBlock(IMP anImp)
     BOOL imp_removeBlock(IMP anImp)
     
    */
    return 0;
}
//属性相关API
int somePropertyAboutRuntimeApi()
{
    //    Person1 *person = [[Person1 alloc]init];
    //    person.tall = YES;
    /*
     1. 获取一个属性
     objc_property_t class_getProperty(Class cls, const char *name)
     
     2. 拷贝属性列表（最后需要调用free释放）
     objc_property_t *class_copyPropertyList(Class cls, unsigned int *outCount)
     
     3. 动态添加属性
     BOOL class_addProperty(Class cls, const char *name, const objc_property_attribute_t *attributes,
     unsigned int attributeCount)
     
     4. 动态替换属性
     void class_replaceProperty(Class cls, const char *name, const objc_property_attribute_t *attributes,
     unsigned int attributeCount)
     
     5. 获取属性的一些信息
     const char *property_getName(objc_property_t property)
     const char *property_getAttributes(objc_property_t property)
     
     */
    
    return 1;
}


//Runtime 成员变量相关API
int someIVarsAboutRuntimeApi()
{
    //获取成员变量的信息
    Ivar nameIVar = class_getInstanceVariable([Car class], "_name");
    //获取成员变量的名字和编码
    NSLog(@"%s,%s",ivar_getName(nameIVar),ivar_getTypeEncoding(nameIVar));
    
    Car *person = [[Car alloc]init];
    // 设置和获取成员变量的值
    object_setIvar(person, nameIVar, @"@YES");
    NSLog(@"%@", object_getIvar(person, nameIVar));
    NSLog(@"%@", person.name);
    
    //拷贝实例变量列表
    unsigned int count;
    Ivar *ivars = class_copyIvarList([Car class], &count);
    
    for (int i = 0; i < count; i++) {
        //取出成员变量
        Ivar ivar = ivars[i];
        NSLog(@"%s, %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
        
    }
    free(ivars);
    
    return 1;
}

// Rutime 类相关API
int someClassAboutRuntimeAPI()
{
    // 创建类 superclass:继承自哪个类 name:类名 size_t:格外的大小，创建类是否需要扩充空间
    // 返回一个类对象
    Class newClass = objc_allocateClassPair([NSObject class], "Student3", 0);//"Student3"//和项目中的Class 最好不要重名，应该是优先OC的Class创建或编译。
    
    // 添加成员变量
    // cls:添加成员变量的类 name:成员变量的名字 size:占据多少字节 alignment:内存对齐，最好写1 types:类型，int类型就是@encode(int) 也就是i
    class_addIvar(newClass, "_age", 4, 1, @encode(int));
    class_addIvar(newClass, "_height", 4, 1, @encode(float));
    
    //添加方法
    class_addMethod(newClass, @selector(run), (IMP)run, "v@:");
    
    //注册类
    objc_registerClassPair(newClass);
    
    //创建实例对象
    id student = [[newClass alloc]init];
    
    
    //通过KVC访问
    [student setValue:@10 forKey:@"_age"];
    [student setValue:@180.5 forKey:@"_height"];
    
    // 获取成员变量
    NSLog(@"_age = %@ , _height = %@",[student valueForKey:@"_age"], [student valueForKey:@"_height"]);
    
    //获取类的占用空间
    NSLog(@"类的占用空间%zd",class_getInstanceSize(newClass));
    
    [student run];
    
    
    return 1;
}


@end
