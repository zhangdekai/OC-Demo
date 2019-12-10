//
//  Car.m
//  Test
//
//  Created by 张德凯 on 2018/8/15.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import "Car.h"

@implementation Car

- (void)driving
{
    NSLog(@"I am Car , I can driving");
}

- (int)driving1:(int)time
{
    NSLog(@"I am Class Car , I can driving1 ");

    NSLog(@"car driving %d",time);
    return time * 2;
}

+ (void)driving2
{
    NSLog(@"I am Class Car , I can driving2 , I am class method ");
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    
    
    NSString *selString = NSStringFromSelector(aSelector);
    
    NSLog(@"没有找到%@ 方法", selString);
    
}


@end
