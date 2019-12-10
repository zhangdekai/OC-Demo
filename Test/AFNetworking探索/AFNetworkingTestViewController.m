
//
//  AFNetworkingTestViewController.m
//  Test
//
//  Created by 张德凯 on 2018/8/24.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import "AFNetworkingTestViewController.h"
#import <AFNetworking.h>

/*
 
 AFNetworking到底做了什么？3.x版本 :http://www.cocoachina.com/articles/18277
 
 
 
 
 */

@interface AFNetworkingTestViewController ()

@end

@implementation AFNetworkingTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];

    [manager GET:@"" parameters:nil
        progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"%@",downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"responseObject");
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error");
        }];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
