//
//  Person.m
//  Test
//
//  Created by zhang dekai on 2025/8/6.
//  Copyright © 2025 张德凯. All rights reserved.
//

#import "DecortorPerson.h"
#import "Finery.h"

@implementation DecortorPerson

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

- (void)show {
    NSLog(@"装扮的好的 - %@", self.name);
}

- (void)testDecortorMode {
    
    // 创建一个人
    DecortorPerson *person = [[DecortorPerson alloc]initWithName:@"小帅"];
    
    // 创建各种服饰
    
    Hat *hat = [[Hat alloc]init];
    TShirt *tShirt = [[TShirt alloc]init];
    Shoes *shoes = [[Shoes alloc]init];
    Pants *pants = [[Pants alloc]init];
    
    // 装饰过程
    [hat decorate:person];
    [tShirt decorate:hat];
    [pants decorate:tShirt];
    [shoes decorate:pants];


    // 展示最终装扮效果
    NSLog(@"开始展示装扮过程：");
    [shoes show];
    
    /*
     2025-08-06 20:05:40.279158+0800 Test[40901:14899338] 开始展示装扮过程：
     2025-08-06 20:05:40.279296+0800 Test[40901:14899338] 穿上鞋子
     2025-08-06 20:05:40.279406+0800 Test[40901:14899338] 穿上裤子
     2025-08-06 20:05:40.279501+0800 Test[40901:14899338] 穿上TShirt
     2025-08-06 20:05:40.279593+0800 Test[40901:14899338] 带上帽子
     2025-08-06 20:05:40.279687+0800 Test[40901:14899338] 装扮的好的 - 小帅
     */
    
}

@end
