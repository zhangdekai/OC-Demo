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

@end
