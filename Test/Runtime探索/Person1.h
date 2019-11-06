//
//  Person1.h
//  Test
//
//  Created by 张德凯 on 2018/8/8.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person1 : NSObject
{
    // 1： 位运算 的方法   char _tallRichHandsome;
    /* 2:  位域 的方法
    struct {
        char handsome : 1; // 位域，代表占用一位空间
        char rich : 1;  // 按照顺序只占一位空间
        char tall : 1;
    }_tallRichHandsome;
     
     */
    
    //共用体 的方法
    union {
        char bits;
        //结构体仅仅是为了增强代码可读性，无实质用处
        struct {
            char handsome : 1; //只占一个 二进制位
            char rich : 1;
            char tall: 1;
        };
    }_tallRichHandsome;
    
}

@property (nonatomic, assign) BOOL tall;
@property (nonatomic, assign) BOOL rich;
@property (nonatomic, assign) BOOL handsome;

@property (nonatomic, strong) NSString *name;

-(void)test;

@end
