//
//  DeviceManager.m
//  Test
//
//  Created by zhang dekai on 2024/3/11.
//  Copyright © 2024 张德凯. All rights reserved.
//

#import "DeviceManager.h"

@implementation DeviceManager


+ (instancetype)shareInstance {
    
    static DeviceManager *instance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[DeviceManager alloc]init];
    });
    
    return instance;
    
}

- (void)configDevice:(BOOL)hasSafeArea{
    self.hasSafeArea = hasSafeArea;
    if(hasSafeArea){
        self.navigationBarStateH = 44.0;
        self.navigationBarH = 88.0;
        self.navigationBarTotalH = 88+44;
    }  else {
        self.navigationBarStateH = 20.0;
        self.navigationBarH = 44.0;
        self.navigationBarTotalH = 44+20;
    }
}



@end
