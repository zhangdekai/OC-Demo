//
//  NSObject+tools.m
//  Test
//
//  Created by zhang dekai on 2020/6/26.
//  Copyright © 2020 张德凯. All rights reserved.
//

#import "NSObject+tools.h"
#import <objc/runtime.h>


@implementation NSObject (tools)

- (NSUInteger)retainCount1 {
    return [self retainCount];
}

@end
