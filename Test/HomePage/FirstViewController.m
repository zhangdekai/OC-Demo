//
//  FirstViewController.m
//  Test
//
//  Created by zhang dekai on 2024/3/5.
//  Copyright © 2024 张德凯. All rights reserved.
//

/*
 
 https://blog.csdn.net/weixin_50990189/article/details/121776665
 
 Sample Demo for UICollectionView:
 
 create cell by xib, add constrants
 
 
 */

#import "FirstViewController.h"
#import "CommonDataModel.h"
#import "FirstVCCollectionViewCell.h"
#import "DeviceManager.h"
#import "PrototypeModeTest.h"
#import "TemplateTest.h"
#import "FacadeTest.h"
#import "BuilderModeTest.h"
#import "ObserverModeTest.h"
#import "PublisherSubscribeModeTest.h"
#import "AbstractFactoryModeTest.h"

@interface FirstViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UINavigationBar *navigationBar;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<CommonDataModel *> *dataList;

@end


@implementation FirstViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"UICollectionView";
    
    //    [self addNavigationBar];
    
    [self initData];
    
    [self initCollectionView];
    
    [_collectionView reloadData];
    
}

- (void)initData {
    
    _dataList = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        CommonDataModel *model = [[CommonDataModel alloc]init];
        model.title = [NSString stringWithFormat:@"Title_%d", i];
        model.subTitle = [NSString stringWithFormat:@"SubTitle_%d", i];
        model.descrip = [NSString stringWithFormat:@"This is description at %d", i];
        if(i == 0){
            model.title = @"原型模式";
            model.subTitle = @"Prototype测试";
        } else if (i== 1){
            model.title = @"模版模式";
            model.subTitle = @"Template测试";
            
        }else if (i== 2){
            model.title = @"外观模式";
            model.subTitle = @"Facade测试";
            
        }else if (i== 3){
            model.title = @"建造者模式";
            model.subTitle = @"Builder测试";
            
        }else if (i== 4){
            model.title = @"观察者模式";
            model.subTitle = @"Observe测试";
        }else if (i== 5){
            model.title = @"发布/订阅模式";
            model.subTitle = @"Publish测试";
        }else if (i== 6){
            model.title = @"抽象工厂模式";
            model.subTitle = @"Abstract Factory测试";
            
        }
        [_dataList addObject:model];
    }
    
    NSLog(@"_dataList == %@", _dataList);
}

- (void)addNavigationBar {
    
    UINavigationItem *item = [[UINavigationItem alloc]initWithTitle:@"UICollectionView"];
    
    _navigationBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, [DeviceManager shareInstance].navigationBarStateH, UIScreenWidth, 44)];
    _navigationBar.items = @[item];
    _navigationBar.barTintColor = [UIColor yellowColor];
    
    [self.view addSubview: _navigationBar];
}

- (void)initCollectionView{
    
    if(!_collectionView){
        
        UICollectionViewFlowLayout *flowLayout  = [[UICollectionViewFlowLayout alloc]init];
        
        //        flowLayout.itemSize = CGSizeMake(UIScreenWidth / 3.0 - 30, 153);
        flowLayout.minimumLineSpacing = 15; // 纵向
        //        flowLayout.minimumInteritemSpacing = 10;
        
        CGRect rect = self.view.bounds;
        //        rect.origin.y = CGRectGetMaxY(_navigationBar.frame);
        
        _collectionView = [[UICollectionView alloc]initWithFrame: rect collectionViewLayout:flowLayout];
        
        [self.view addSubview:_collectionView];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"FirstVCCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"FirstVCCollectionViewCell"];
        
    }
}

#pragma mark - UICollectionDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return  _dataList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    FirstVCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FirstVCCollectionViewCell" forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[FirstVCCollectionViewCell alloc]init];
    }
    
    [cell setCellModel:_dataList[indexPath.row]];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"collectionView didSelectItemAtIndexPath row == %ld section==%ld", indexPath.row, indexPath.section);
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            testPrototypeMain();
        }else if(indexPath.row == 1){
            testTemplateMain();
        } else if(indexPath.row == 2){
            testFacadeMain();
        }else if(indexPath.row == 3){
            testBuilderModeMain();
        }else if(indexPath.row == 4){
            testObserveModeMain();
        }else if(indexPath.row == 5){
            testObserveModeMain();
        }else if(indexPath.row == 6){
            testAbstractFactoryMain();
        }
        
    }
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(UIScreenWidth / 2 - 20, 154);
}



- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return  UIEdgeInsetsMake(0, 15, 0, 15);
}



@end
