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
        
     }
    return self;
}

- (void)driving
{
    NSLog(@"I am Student , I can driving");
}

@end
