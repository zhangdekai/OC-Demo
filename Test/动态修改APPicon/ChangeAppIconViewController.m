


//
//  ChangeAppIconViewController.m
//  Test
//
//  Created by 张德凯 on 2018/9/11.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import "ChangeAppIconViewController.h"
#import <objc/runtime.h>

@interface ChangeAppIconViewController ()

@end

/**
 更换APP icon
 */
@implementation ChangeAppIconViewController

+ (void)load
{
   /*
    // runtime交换方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method presentM = class_getInstanceMethod(self.class, @selector(presentViewController:animated:completion:));
        
        Method presentSwizzlingM = class_getInstanceMethod(self.class, @selector(lq_presentViewController:animated:completion:));
        
        method_exchangeImplementations(presentM, presentSwizzlingM);
        
    });
  */
}

/**
 隐藏掉系统的弹窗（UIAlterViewController）

 @param viewControllerToPresent UIViewController
 @param flag BOOL
 @param completion completion Block
 */
- (void)lq_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    
    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
        UIAlertController *alter = (UIAlertController *)viewControllerToPresent;
        if (alter.title == nil && alter.message == nil) {
            return;
        }
    }

    [self lq_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor whiteColor];

    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.frame = CGRectMake(100, 150, 50, 50);
    [self.view addSubview:imageview];
    
    imageview.image = [UIImage imageNamed:@"leopard"];
    
    UIImageView *imageview1 = [[UIImageView alloc]init];
    imageview1.frame = CGRectMake(100, CGRectGetMaxY(imageview.frame) + 50, 50, 50);
    [self.view addSubview:imageview1];
    
    imageview1.image = [UIImage imageNamed:@"dusk"];

    
    imageview.userInteractionEnabled = YES;
    imageview1.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeLeopard)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeDusk)];
    
    [imageview addGestureRecognizer:tap];
    [imageview1 addGestureRecognizer:tap1];

}

- (void)changeDusk
{
    [self changeAppIconWithName:@"dusk"];
}

- (void)changeLeopard
{
    [self changeAppIconWithName:@"leopard"];
}


/**
 更换APP icon

 @param iconName NSString
 */
- (void)changeAppIconWithName:(NSString *)iconName
{
    if (![[UIApplication sharedApplication] supportsAlternateIcons]) {
        return;
    }
    
    if ([iconName isEqualToString:@""]) {
        iconName = nil;
    }
    
    [[UIApplication sharedApplication]setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"更换的APP图片失败:%@",error);
        }
    }];
}

@end
