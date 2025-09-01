//
//  Student.m
//  Test
//
//  Created by 张德凯 on 2018/8/16.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import "Student1.h"
#import <objc/runtime.h>

@implementation Student1

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSLog(@"[self class] = %@", [self class]);
        NSLog(@"[self superclass] = %@", [self superclass]);
        NSLog(@"----------------");
        NSLog(@"[super class] = %@", [super class]);
        NSLog(@"[super superclass] = %@", [super superclass]);
        /*
         [self class] = Student1
         [self superclass] = Person1
          ----------------
         [super class] = Student1
         [super superclass] = Person1
         */
        
        NSLog(@"%d",[Student1 isKindOfClass:[Student1 class]]);// 0
        NSLog(@"%d",[Student1 isKindOfClass:object_getClass([Student1 class])]);// 1
        NSLog(@"%d",[Student1 isKindOfClass:[NSObject class]]);// 1
        
        /*
         isKindOfClass： 适合用来判断“是否属于某个类族”。
         
         判断对象是否是 某个类或其子类 的实例。

         换句话说，它会 顺着继承链 往上找。
         
         isMemberOfClass：
         
         判断对象是否是 某个类的实例（不包括子类）。

         不会检查继承链，只对比当前对象所属的类。
         
         Dog *d = [Dog new];

         [d isMemberOfClass:[Dog class]];    // YES
         [d isMemberOfClass:[Animal class]]; // NO
         [d isMemberOfClass:[NSObject class]];// NO
         */
        
     }
    return self;
}

- (void)driving
{
    NSLog(@"I am Student , I can driving");
}

@end
