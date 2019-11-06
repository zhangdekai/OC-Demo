//
//  ViewController.m
//  Test
//
//  Created by 张德凯 on 2018/4/14.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import "ViewController.h"
#import "SubTableViewCell.h"
#import "NSObjectTestView.h"
#import "KVOExploreViewController.h"
#import "RunloopTestViewController.h"
#import "ChangeAppIconViewController.h"

//#import "Person.h"
#import "Person1.h"
#import "Person2.h"
#import "Student1.h"
#import "Car.h"

#import <objc/runtime.h>

#import "BinaryTreeNode.h"

#import <AVFoundation/AVFoundation.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *aview = [[UIView alloc]init];
    aview.layer.shouldRasterize = YES;
    
    
    
    
    
    
    [self testTree];
    
    
    
    
    //test WebP
    
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.frame = CGRectMake(0, 100, UIScreenWidth, 500);
    [self.view addSubview:imageview];
    
//    imageview.image = [UIImage imageNamed:@"timg.jpeg"];
    
    imageview.image = [UIImage imageNamed:@"test-daqiao"];

    
    
    
    
    
//    NSString *string = @"string";
//
//
//    id cls = [Person1 class];
//    void *obj = &cls;
//    [(__bridge id)obj test];

    
    
    
//    NSString *test = @"是的是的临床科室领导开车你老是";
   
  
    
//    NSObjectTestView *textRuntime = [[NSObjectTestView alloc]init];

    
    UIButton *takePhoto = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 30)];
    [takePhoto setTitle:@"去拍照" forState:0];
    [takePhoto setTitleColor:[UIColor blackColor] forState:0];
    [self.view addSubview:takePhoto];
    [takePhoto addTarget:self action:@selector(takePhoto) forControlEvents:(UIControlEventTouchUpInside)];
    
//    NSArray *asds = [self photos_current_role_tag];
//    NSLog(@"sdcsdcsdc :%@",asds);
    
    
}

- (void)testTree {
    
    NSArray *testTree = @[@"1",@"5",@"3",@"2",@"9",@"10",@"11",@"6"];
    
    BinaryTreeNode *tree = [BinaryTreeNode createBinaryTreeNodeWithValues:testTree];
    
    BinaryTreeNode *findedNode = [BinaryTreeNode findTreeNodeAtIndex:2 withTree:tree];
    
    NSLog(@"寻到的Node:%ld",findedNode.keyValue);

    
    
    BinaryTreeNode *minNode = [BinaryTreeNode findMinTreeNode:tree];
    
    NSLog(@"最小的Node:%ld",minNode.keyValue);

    
    [BinaryTreeNode preOrderTraverseBinaryTree:tree handle:^(BinaryTreeNode * _Nonnull treeNode) {
        NSLog(@"节点value:%ld",treeNode.keyValue);
    }];
    
    NSInteger treeDeep = [BinaryTreeNode depthOfBinaryTree:tree];
    
    NSLog(@"二叉树的深度:%ld",treeDeep);
    
    NSInteger treeWidth = [BinaryTreeNode widthOfBinaryTree:tree];

    NSLog(@"二叉树的宽度:%ld",treeWidth);
    
    NSInteger numOfTree = [BinaryTreeNode numberOfBinaryTree:tree];
    
    NSLog(@"二叉树的节点个数：%ld",numOfTree);
    
    NSInteger numOflevel = [BinaryTreeNode numberOfBinaryTreeNodesOnLevel:4 inBinaryTree:tree];
    
    NSLog(@"二叉树4层的节点个数：%ld",numOflevel);
    
    BinaryTreeNode *invertTree = [BinaryTreeNode invertBinaryTree:tree];
    NSLog(@"反转后的二叉树的根节点：%ld",invertTree.keyValue);

    
}

- (void)takePhoto {
    
//    KVOExploreViewController *vc = [[KVOExploreViewController alloc]init];
    ChangeAppIconViewController *vc = [[ChangeAppIconViewController alloc]init];

//    RunloopTestViewController *vc = [[RunloopTestViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:nil];
}

- (CGSize)getLabelSizeByString:(NSString *)string stringFont:(CGFloat)font {
    if (string.length == 0) {
        return CGSizeZero;
    }
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:font];
    label.numberOfLines = 0;
    label.text = string;
    [label sizeToFit];
    
    CGSize size = label.frame.size;
    return size;
    
}

- (NSArray *)photos_current_role_tag {
    
    NSArray *titleArray = @[@"*左前角",@"*左后角",@"*右后角",@"*右前角",@"*里程油表"];
    NSArray *_photos_current_role_tag = @[@"*左前角1",@"*左后角1",@"*右后角",@"*右前角",@"*里程油表"];
    NSMutableArray *photos_tag = [NSMutableArray array];
    
    for (NSString *model in _photos_current_role_tag) {
        for (NSString *obj in titleArray) {
            if ([obj isEqualToString:model]) {
                [photos_tag addObject:obj];
                break;
            }
        }
    }
    
    return (NSArray*)photos_tag;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
