//
//  SDWebImageTestViewController.m
//  Test
//
//  Created by zhang dekai on 2019/12/9.
//  Copyright © 2019 张德凯. All rights reserved.
//

#import "SDWebImageTestViewController.h"
#import <SDWebImage.h>

/*
 
 SDWebimage源码解读：https://www.jianshu.com/p/fc8e8994dde7
 
 SDImageCache实现缓存
 内存缓存
 disk缓存，存到沙盒 异步串行存储图片（io操作），避免了锁的出现
 
 
 */

@interface SDWebImageTestViewController ()

@end

@implementation SDWebImageTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.frame = CGRectMake(0, 100, UIScreenWidth, 300);
    [self.view addSubview:imageview];
    
    [imageview sd_setImageWithURL:[NSURL URLWithString:@"http://attach.bbs.miui.com/forum/month_1012/10120514509c7244b23f4a2fa5.jpg"] placeholderImage:[UIImage imageNamed:@"sd_testimg"]];
    
    
    
    
}

- (void)testNSCacheAndDict {
    NSCache *cache = [[NSCache alloc]init];
    
    [cache setName:@"test_cache"];
    
    [cache setObject:@"你好擦车" forKey:@"key01"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:@"testDict" forKey:@"dcit"];
}



@end
