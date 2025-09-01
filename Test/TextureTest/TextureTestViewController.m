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
 
 Texture 异步渲染的核心原理是：
 
 通过节点封装将渲染任务拆分，利用后台线程并行处理布局和绘制，最后在主线程高效合成图层。这一机制避开了主线程的性能瓶颈，尤其在复杂界面（如信息流、长列表）中能显著提升流畅度。
 其本质是用多线程并行计算换取主线程空闲，同时通过缓存和增量更新进一步降低开销，最终实现 “高帧率渲染” 的目标。
 
 为什么要使用 ASDK？ ASDK 不在维护了，更改为 pod "Texture"
 
 图形异步渲染
 
 通常我们认为 UIKit 是不能渲染于非主线程的, 一旦你这么做, 就可能会导致崩溃, 无法正常显示等问题,
 
 而 ASDK 为什么可以呢。
 
 因为 ASDisplayNode 是线程安全的, Node 创建时, 不会立即在其内部新建 UIView 和 CALayer, 直到主线程第一次访问时才会生成对应的对象, 除此之外,
 还通过图层预合成和基于 Runloop 的异步并发, 使其拥有更好的性能 ASAsyncTransactionGroup
 
 这个特点带来的相关实际体验就是: 安心的进行异步绘图, 如圆角裁剪, 增加遮罩等, 这在 UIKit 中是足以毁灭人生的, 内存暴涨, 异步复用, 性能极差
 */

#import "TextureTestViewController.h"
#import "TextureGridCell.h"

// 视图控制器实现
@interface TextureTestViewController () <ASCollectionDataSource, ASCollectionDelegate>

@property (nonatomic, strong) ASCollectionNode *collectionNode;
@property (nonatomic, strong) NSArray *imageData; // 存储图片数据

@end

@implementation TextureTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"图片网格";
    
//    [self addCollectionNode];
    [_collectionNode reloadData];
}

- (NSArray *)configImgData {
    return @[
        @{@"url": @"https://picsum.photos/400/400?random=1", @"title": @"风景照片 1"},
        @{@"url": @"https://picsum.photos/400/400?random=2", @"title": @"风景照片 2"},
        @{@"url": @"https://picsum.photos/400/400?random=3", @"title": @"风景照片 3"},
        @{@"url": @"https://picsum.photos/400/400?random=4", @"title": @"风景照片 4"},
        @{@"url": @"https://picsum.photos/400/400?random=5", @"title": @"风景照片 5"},
        @{@"url": @"https://picsum.photos/400/400?random=6", @"title": @"风景照片 6"},
        @{@"url": @"https://picsum.photos/400/400?random=7", @"title": @"风景照片 7"},
        @{@"url": @"https://picsum.photos/400/400?random=8", @"title": @"风景照片 8"}
    ];
}

- (instancetype)init {
    // 创建网格布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemSize = ([[UIScreen mainScreen] bounds].size.width - 30) / 2; // 两列布局
    layout.itemSize = CGSizeMake(itemSize, itemSize + 30); // 图片高度 + 文本高度
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    // 初始化 collectionNode
    _collectionNode = [[ASCollectionNode alloc] initWithCollectionViewLayout:layout];
    _collectionNode.backgroundColor = [UIColor whiteColor];
    
    self = [super initWithNode:_collectionNode];
    if (self) {
        _collectionNode.dataSource = self;
        _collectionNode.delegate = self;
        
        // 模拟数据
        _imageData = [self configImgData];
    }
    return self;
}

#pragma mark - ASCollectionDataSource

- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {
    return self.imageData.count;
}

- (ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *data = self.imageData[indexPath.item];
    NSURL *imageURL = [NSURL URLWithString:data[@"url"]];
    NSString *title = data[@"title"];
    
    // 使用 block 方式返回单元格，便于异步处理
    return ^{
        TextureGridCell *cell = [[TextureGridCell alloc] init];
        [cell configureWithImageURL:imageURL title:title];
        return cell;
    };
}

#pragma mark - ASCollectionDelegate

- (void)collectionNode:(ASCollectionNode *)collectionNode didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionNode deselectItemAtIndexPath:indexPath animated:YES];
    
    NSDictionary *data = self.imageData[indexPath.item];
    
    NSLog(@"选中了: %@", data[@"title"]);
    
    // 这里可以添加点击事件处理，如跳转详情页等
}

#pragma mark - 优化方法

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode sizeRangeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 定义单元格的尺寸范围，有助于 Texture 优化布局
    CGFloat itemSize = ([[UIScreen mainScreen] bounds].size.width - 30) / 2;
    return ASSizeRangeMake(CGSizeMake(itemSize, itemSize + 30),
                           CGSizeMake(itemSize, itemSize + 30));
}

- (void)textUIView{
    /// ASDisplayNode == UIView
    ASDisplayNode *node = [[ASDisplayNode alloc] init];
    node.backgroundColor = [UIColor orangeColor];
    node.bounds = CGRectMake(0, 0, 100, 100);
    
    NSLog(@"Underlying view: %@", node.view);
    
    
    ASDisplayNode *node1 = [[ASDisplayNode alloc] init];
    node1.clipsToBounds = YES;                  // not .masksToBounds
    node1.borderColor = [[UIColor blueColor] CGColor];  //layer name when there is no UIView equivalent
    
    NSLog(@"Backing layer: %@", node1.layer);
    
    ASDisplayNode *node2 = [[ASDisplayNode alloc] initWithViewBlock:^{
        UIView *view  = [[UIView alloc] init];
        return view;
    }];
}

@end
