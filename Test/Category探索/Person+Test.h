//
//  Person+Test.h
//  Test
//
//  Created by 张德凯 on 2018/8/6.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import "Person.h"

@interface Person (Test)<NSCopying>

- (void)test;

+ (void)abc;

@property (nonatomic, assign) NSInteger age;

- (void)setAge:(NSInteger)age;

- (NSInteger)age;


@end

