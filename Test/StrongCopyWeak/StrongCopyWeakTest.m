//
//  StrongCopyWeakTest.m
//  Test
//
//  Created by zhang dekai on 2021/3/6.
//  Copyright © 2021 张德凯. All rights reserved.
//

#import "StrongCopyWeakTest.h"

@interface StrongCopyWeakTest ()


@end

@implementation StrongCopyWeakTest

- (void)testMutabeCopy {
    //
    NSArray *a = @[@"qwe", @"qwe1", @"qwe2", @"qwe3"];
    NSMutableArray *b = [a copy];// 这种写法crash，b 会变化为NSArray，不可添加新元素。
    b = [a mutableCopy];
    [b addObject:@"123"];
    
    for (NSString *str in b) {
        NSLog(@"%@", [str stringByAppendingString:@"\n"]);
    }
}

@end
