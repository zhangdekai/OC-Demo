//
//  main.m
//  Test
//
//  Created by 张德凯 on 2018/4/14.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <malloc/malloc.h>
#import "TestBlock.h"
#import "Person1.h"
#import "Car.h"
#import <objc/runtime.h>

#include "MyListTest.hpp"
#import "NSObject+HashTable.h"


void run(id self, SEL _cmd);

int someClassAboutRuntimeAPI(void);//向前声明方法
int someIVarsAboutRuntimeApi(void);
int somePropertyAboutRuntimeApi(void);


int main(int argc, char * argv[]) {
    
    @autoreleasepool {
        
//        [NSObject testCase];
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//        NSLog(@"%zd",class_getInstanceSize([Person1 class]));
                        
    }
    return 0;
}




