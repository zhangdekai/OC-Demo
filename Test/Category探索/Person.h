//
//  Person.h
//  Test
//
//  Created by 张德凯 on 2018/7/31.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString *name;


- (void)run;

@end
