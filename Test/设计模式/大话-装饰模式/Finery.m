//
//  Finery.m
//  Test
//
//  Created by zhang dekai on 2025/8/6.
//  Copyright © 2025 张德凯. All rights reserved.
//

#import "Finery.h"

@implementation Finery

- (void)decorate:(id<PersonProtocol>)person {
    self.person = person;
}

- (void)show {
    if (self.person) {
        [self.person show];
    }
}

@end

@implementation Hat


- (void)show {
    NSLog(@"帽子 ");

    [super show];
}

@end

@implementation Pants


- (void)show {
    NSLog(@"裤子 ");

    [super show];
}

@end

@implementation Shoes


- (void)show {
    NSLog(@"鞋子");

    [super show];
}

@end

@implementation TShirt


- (void)show {
    NSLog(@"TShirt ");

    [super show];
}

@end
