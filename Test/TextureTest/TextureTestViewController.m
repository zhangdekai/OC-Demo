//
//  TextUreTestViewController.m
//  Test
//
//  Created by zhang dekai on 2019/11/6.
//  Copyright © 2019 张德凯. All rights reserved.
//

/*
 Texture:
 
 使用node的一个关键优势是，所有node都在主线程之外执行布局和显示，
 因此主线程可以立即响应用户交互事件。
 
 为什么要使用 ASDK

 图形异步渲染

 通常我们认为 UIKit 是不能渲染于非主线程的, 一旦你这么做, 就可能会导致崩溃, 无法正常显示等问题,
 
 而 ASDK 为什么可以呢。
 
 因为 ASDisplayNode 是线程安全的, Node 创建时, 不会立即在其内部新建 UIView 和 CALayer, 直到主线程第一次访问时才会生成对应的对象, 除此之外,
 还通过图层预合成和基于 Runloop 的异步并发, 使其拥有更好的性能 ASAsyncTransactionGroup

 这个特点带来的相关实际体验就是: 安心的进行异步绘图, 如圆角裁剪, 增加遮罩等, 这在 UIKit 中是足以毁灭人生的, 内存暴涨, 异步复用, 性能极差
 */

#import "TextureTestViewController.h"

@interface TextureTestViewController ()

@end

@implementation TextureTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
}


@end
