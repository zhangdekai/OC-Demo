//
//  OCAlgorithmTest.m
//  Test
//
//  Created by zhang dekai on 2019/12/15.
//  Copyright © 2019 张德凯. All rights reserved.
//

#import "OCAlgorithmTest.h"
#import <UIKit/UIKit.h>

@implementation OCAlgorithmTest

#pragma mark - 查找两个子视图的共同父视图
/*
 思路:分别记录两个子视图的所有父视图并保存到数组中，然后倒序寻找,直至找到第一个不一样的父视图。
 */
- (void)findCommonSuperViews:(UIView *)view1 view2:(UIView *)view2 {
    
    NSArray * superViews1 = [self findSuperViews:view1];
    
    NSArray * superViews2 = [self findSuperViews:view2];
    
    NSMutableArray * resultArray = [NSMutableArray array];
    
    int i = 0;
    
    while (i < MIN(superViews1.count, superViews2.count)) {
        
        UIView *super1 = superViews1[superViews1.count - i - 1];
        
        UIView *super2 = superViews2[superViews2.count - i - 1];
        
        if (super1 == super2) {
            
            [resultArray addObject:super1];
            
            i++;
            
        } else {
            
            break;
        }
    }
    
    NSLog(@"resultArray:%@",resultArray);
    
}
- (NSArray <UIView *>*)findSuperViews:(UIView *)view {
    
    UIView * temp = view.superview;
    
    NSMutableArray * result = [NSMutableArray array];
    
    while (temp) {
        
        [result addObject:temp];
        
        temp = temp.superview;
    }
    
    return result;
}
@end
