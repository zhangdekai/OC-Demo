//
//  TestNSUseDefault.m
//  Test
//
//  Created by zhang dekai on 2021/4/1.
//  Copyright © 2021 张德凯. All rights reserved.
//

#import "TestNSUseDefault.h"

@implementation TestNSUseDefault

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"user_test"];

        [[NSUserDefaults standardUserDefaults]setValue:@"value" forKey:@"user_value"];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"user_test"];

        
    }
    return self;
}

@end
