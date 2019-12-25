//
//  iOS_APITestViewController.m
//  Test
//
//  Created by zhang dekai on 2019/12/6.
//  Copyright © 2019 张德凯. All rights reserved.
//

#import "iOS_APITestViewController.h"
#import "YYWeakProxy.h"


@interface iOS_APITestViewController ()


@property (nonatomic, strong) NSTimer *timer;


@end



@implementation iOS_APITestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSObject *obj = [[NSObject alloc] init];
    
//    NSURLProtocol *Protocol = [NSURLProtocol alloc]initWithRequest:<#(nonnull NSURLRequest *)#> cachedResponse:<#(nullable NSCachedURLResponse *)#> client:<#(nullable id<NSURLProtocolClient>)#>
    
    
//    NSException
    
    //signal(<#int#>, <#void (*)(int)#>)
    
   // NSSetUncaughtExceptionHandler(&uncaughtEX);
    
//    CALayer

}

- (void)TestNSProxy {
    
    YYWeakProxy *weakProxy = [YYWeakProxy weakProxyWithTarget:self];
    
    _timer = [NSTimer timerWithTimeInterval:1 target:weakProxy selector:@selector(timeClick:) userInfo:nil repeats:YES];
    
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:weakProxy selector:@selector(timeClick:)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];

}

- (void)timeClick:(NSTimer *)timer {}




-(void)dealloc {
    if (_timer.valid) {
        [_timer invalidate];
    }
}



@end
