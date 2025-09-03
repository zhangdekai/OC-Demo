//
//  SecondViewController.m
//  Test
//
//  Created by zhang dekai on 2024/3/5.
//  Copyright © 2024 张德凯. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondVCTableViewCell.h"
#import "TextureTestViewController.h"
#import "MVCUserListViewController.h"

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource,SecondVCCellActionsDelagate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<CommonDataModel *> *dataList;


@end

@implementation SecondViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    NSLog(@"SecondViewController viewDidLoad");
    
    [self initTableView];
    
    [_tableView reloadData];
    
}

- (void)initData {
    
    _dataList = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        CommonDataModel *model = [[CommonDataModel alloc]init];
        model.title = [NSString stringWithFormat:@"Title_%d", i];
        model.subTitle = [NSString stringWithFormat:@"SubTitle_%d", i];
        model.descrip = [NSString stringWithFormat:@"This is description at %d", i];
        [_dataList addObject:model];
        if(i == 0){
            model.title = @"TextureTestViewController";
            model.descrip = @"Test TextureTestViewController";
            
        }else if(i == 1){
            model.title = @"MVC Demo";
            model.descrip = @"Test MVC";
            
        }
    }
    
    NSLog(@"_dataList == %@", _dataList);
}

- (void)initTableView {
    
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame: self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        
    }
    [_tableView registerClass:[SecondVCTableViewCell class] forCellReuseIdentifier:@"SecondVCTableViewCell"];
    
    _tableView.backgroundColor = [UIColor whiteColor];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.tableHeaderView = [self tableHeaderView];
    
    //        _tableView.rowHeight = 48;
    //        _tableView.estimatedRowHeight = 50;
    //        _tableView.sectionHeaderHeight = 30;
    
}

- (UIView *)tableHeaderView{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 100)];
    header.backgroundColor = [UIColor colorWithRed:0 green:0.6 blue:0 alpha:0.3];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, UIScreenWidth, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    
    label.text = @"UITableView";
    
    [header addSubview:label];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, UIScreenWidth, 20)];
    label1.text = @" Builded by Frame, and this is Table Header";
    
    [header addSubview:label1];
    
    
    return header;
}

#pragma UITableView delegate and dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 146;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SecondVCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondVCTableViewCell"];
    
    if(cell == nil){
        cell = [[SecondVCTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecondVCTableViewCell"];
    }
    
    [cell setModel: _dataList[indexPath.row]];
    
    cell.delegate = self;
    
    __weak typeof(self) weakSelf =  self;
    cell.commitActionBlock = ^{
        [weakSelf handleCellCommitAction:indexPath];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"didSelectRowAtIndexPath indexPath.row == %ld", indexPath.row);
    if(indexPath.row == 0){
        TextureTestViewController *vc = [[TextureTestViewController alloc]init];
        [self presentViewController:vc animated:YES  completion:nil];
        //        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        
        MVCUserListViewController *vc = [[MVCUserListViewController alloc]init];
        [self presentViewController:vc animated:YES  completion:nil];
        
    }
}



- (void) handleCellCommitAction:(NSIndexPath*) indexPath{
    NSLog(@"handleCellCommitAction indexPath.row == %ld", (long)indexPath.row);
}

#pragma - delegate

- (void)handleAddButtonAction {
    NSLog(@"哈哈- 这里是cell delegate  add action 实现的地方");
}

- (void)handleCommitButtonAction {
    NSLog(@"哈哈- 这里是cell delegate  commit  action 实现的地方");
    
}

@end
