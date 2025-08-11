//
//  StrategyMode.m
//  Test
//
//  Created by zhang dekai on 2025/8/5.
//  Copyright © 2025 张德凯. All rights reserved.
//

#import "StrategyMode.h"
#import <UIKit/UIKit.h>

/*
 
 商场促销- 策略模式
 
 打折，充300赠50，正常收费 三种算法=》 CashPayWay
 
 
 */



#pragma mark - CashPayProtocol 协议的方式也可实现

@protocol CashPayProtocol <NSObject>

- (double)getResult1:(double)money;

@end

#pragma mark - CashPayWay

@interface CashPayWay : NSObject

- (double)getResult:(double)money;

@end

@implementation CashPayWay

- (double)getResult:(double)money {
    
    return money;
}

@end

@interface CashNormal : CashPayWay<CashPayProtocol>

@end

@implementation CashNormal

- (double)getResult:(double)money{
    NSLog(@"正常收费 getResult");
    return money;
}


- (double)getResult1:(double)money {
    NSLog(@"正常收费 getResult");
    return money;
}

@end

@interface CashReturn : CashPayWay

// 声明属性
@property (nonatomic, assign) NSInteger incharge;
@property (nonatomic, assign) NSInteger returnNum;

// 自定义初始化方法（带参数）
- (instancetype)initWithName:(NSInteger)incharge
                   returnNum:(NSInteger)returnNum;

@end

@implementation CashReturn


- (instancetype)initWithName:(NSInteger)incharge returnNum:(NSInteger)returnNum {
    
    self = [super init];
    if(self){
        _incharge = incharge;
        _returnNum = returnNum;
        
    }
    return  self;
}

- (double)getResult:(double)money{
    
    NSLog(@"CashReturn getResult");
    if(money >= 300){
        return money + 100;
    }
    return money;
}

@end

@interface CashRebate : CashPayWay

// 声明属性
@property (nonatomic, assign) double rate;

// 自定义初始化方法（带参数）
- (instancetype)initWithRate:(double)rate;

@end

@implementation CashRebate


- (instancetype)initWithRate:(double)rate{
    
    self = [super init];
    if(self){
        self.rate   = rate;
    }
    return  self;
}

- (double)getResult:(double)money{
    NSLog(@"CashRebate getResult");
    return 100 * _rate;
}

@end


@interface CashContext : NSObject

@property(strong,nonatomic) CashPayWay *cs;

- (void)cashType:(NSString *) type;

- (double)getResult:(double)money;

@end

@implementation CashContext

-(void)cashType:(NSString *)type{
    
    if([type isEqualToString:@"正常收费"]){
        self.cs = [[CashNormal alloc]init];
    } else if([type isEqualToString:@"满300返100"]){
        self.cs = [[CashReturn alloc]initWithName:300 returnNum:100];
    } else if([type isEqualToString:@"打折0.8"]){
        self.cs = [[CashRebate alloc]initWithRate:0.8];
    }
}

- (double)getResult:(double)money {
    
    return [self.cs getResult:money];
}

@end


@implementation StrategyMode


#pragma mark - Test mode
-(void)testStrategyMode {
    
    CashContext *cs = [[CashContext alloc]init];
    [cs cashType:@"打折0.8"];
    [cs getResult:400];
    
    
    // 排序策略
    NSSortDescriptor *p = [[NSSortDescriptor alloc]init];
    
    // 动画策略 UIViewAnimationOptionBeginFromCurrentState
    [UIView animateWithDuration:0.8 delay:1 options:(UIViewAnimationOptionBeginFromCurrentState) animations:^{
        
        //
    } completion:^(BOOL finished) {
        //
    }];
    
}


@end

