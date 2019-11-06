//
//  Car.h
//  Test
//
//  Created by 张德凯 on 2018/8/15.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *names;
- (void)driving;

- (int)driving1:(int)time;

+ (void)driving2;

@end
