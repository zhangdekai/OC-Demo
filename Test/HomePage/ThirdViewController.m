//
//  ThirdViewController.m
//  Test
//
//  Created by zhang dekai on 2024/3/5.
//  Copyright © 2024 张德凯. All rights reserved.
//

#import "ThirdViewController.h"
#import <Masonry.h>

@interface ThirdViewController ()

@property(strong, nonatomic) UIButton *btn;
@property(strong, nonatomic) UIButton *btn1;


@end

@implementation ThirdViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"UIView Test";
    
    [self AddBtn];
    [self AddBtn1];
    
}

- (void)AddBtn {
    UIButton *botton = [[UIButton alloc]initWithFrame: CGRectMake(20, 100, 100, 40)];
    self.btn = botton;
    [self.view addSubview:_btn];
    
    [botton setTitle:@"改变Frame" forState: UIControlStateNormal];
    
    [botton addTarget:self action:@selector(changeBtnFrame) forControlEvents:(UIControlEventTouchUpInside)];
    [botton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)AddBtn1 {
    UIButton *botton = [[UIButton alloc]initWithFrame: CGRectMake(20, 150, 120, 40)];
    self.btn1 = botton;
    [self.view addSubview:botton];
    
    [botton setTitle:@"改变BackgroundColor" forState: UIControlStateNormal];
    [botton addTarget:self action:@selector(changeBtnColor) forControlEvents:(UIControlEventTouchUpInside)];
    [botton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

/// 修改视图的 frame/bounds/center/transform → 系统会自动调用 setNeedsLayout, 触发 layoutSubviews。然后UI更新。
- (void)changeBtnFrame {
    
    /// 自动触发 layoutSubviews
    [_btn setFrame:CGRectMake(200, 100, 100, 40)];
    
    /*
     1. 修改视图的 frame / bounds / center / transform

     view.frame = CGRectMake(50, 50, 100, 100); // 自动触发 layoutSubviews


     2. 调整视图的层级关系

     addSubview:

     removeFromSuperview

     insertSubview:atIndex:

     exchangeSubviewAtIndex:

     3. 旋转屏幕 / 改变父视图大小（父视图 layout → 子视图 layout）

     4. 调用 sizeToFit（内部其实会修改 bounds，进而触发 layout）

     👉 底层逻辑：只要有可能影响 子视图的位置和大小，系统就会帮你调用 setNeedsLayout。
     */
    
}
/// 改变 backgroundColor → 系统会自动调用 setNeedsDisplay, 触发 drawRect。
- (void)changeBtnColor {
    
    [_btn1 setBackgroundColor:[UIColor blueColor] ];// 自动触发 drawRect
    
    /*
     二、会自动触发 setNeedsDisplay 的操作
     视图的 外观内容（颜色 / 样式 / 图形）发生变化时，UIKit 会自动标记“需要重新绘制”。
     典型操作：
     1. 修改 backgroundColor

     view.backgroundColor = [UIColor redColor]; // 自动触发 drawRect
     2. 修改 opaque、hidden、alpha
     3. 修改 contentMode（比如 UIViewContentModeScaleAspectFit → 需要重新绘制内容）

     4. 修改 layer 的部分属性：
     contents（例如更换图片）
     mask、shadow*、cornerRadius、border* 等影响绘制的属性
     👉 底层逻辑：只要有可能影响 视图的内容显示，系统就会帮你调用 setNeedsDisplay。

     */
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
