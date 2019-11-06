//
//  NSObjectTestView.m
//  Test
//
//  Created by 张德凯 on 2018/7/25.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import "NSObjectTestView.h"
#import <objc/runtime.h>

@protocol NSObjectTestViewDelegate <NSObject>

@end

@interface NSObjectTestView()
{
    int a;
    NSArray *array1;
}

@property (nonatomic, assign) int var0;
@property (nonatomic, assign) NSInteger var1;

@property (nonatomic, copy) NSString *property1;
@property (nonatomic, strong) NSMutableArray *property2;


@end

@implementation NSObjectTestView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSObject *obj1 = [[NSObject alloc]init];
        NSObject *obj2 = [[NSObject alloc]init];        
        
        Class obj3 = object_getClass(obj1);
        Class obj4 = object_getClass(obj2);
        
        Class obj5 = object_getClass([obj1 class]);
        Class obj6 = object_getClass([obj2 class]);
        Class obj7 = object_getClass([NSObject class]);
        
        NSLog(@"1:%p %p %p %p %p %p %p", obj1, obj2, obj3, obj4, obj5,obj6,obj7);
        
    }
    return self;
}

- (void)test01 {
    NSLog(@"i am first %@",[self test02]);
    
}

- (NSString *)test02 {
    return @"test02";
}

+ (void)test03 {
    NSLog(@"i am test03 %@",[self test04]);
}

+ (NSString *)test04 {
    return @"i am test04";
}
@end
