//
//  NSObject+addProperty.m
//  Test
//
//  Created by 张德凯 on 2018/8/7.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import "NSObject+addProperty.h"
#import <objc/runtime.h>

@implementation NSObject (addProperty)

- (void)setName:(NSString *)name
{
    //关联对象
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)name
{
    //关联对象
    return objc_getAssociatedObject(self, @"name");
}

- (void)removeAssociatedObjects
{
    // 移除所有关联对象   被关联的对象置为nil，也能删除关联对象。
    objc_removeAssociatedObjects(self);
}


@end
