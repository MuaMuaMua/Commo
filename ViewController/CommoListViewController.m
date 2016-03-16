//
//  CommoListViewController.m
//  Commo
//
//  Created by wuhaibin on 15/12/12.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import "CommoListViewController.h"
#import "CommoListCell.h"
#import "PostCommoViewController.h"

#define winSize  [[UIScreen mainScreen]bounds]

@interface CommoListViewController (){
    UIView * _bottomView;
    UIButton * _button;
    CGFloat _oldPointY;
}

@end

@implementation CommoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _oldPointY = 0;
    [self initTableView];
    [self initBottomView];
    self.bgView.backgroundColor = [UIColor colorWithRed:38.0/255 green:77.0/255 blue:100.0/255 alpha:1];
}

#pragma mark - 初始化tableview的属性

- (void)initTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:38.0/255 green:77.0/255 blue:100.0/255 alpha:1];
}

- (void)initBottomView {

    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, winSize.size.height - 50, winSize.size.width, 50)];
    _bottomView .backgroundColor = [UIColor blackColor];
    
    UIButton * addBtn = [[UIButton alloc]initWithFrame:CGRectMake(winSize.size.width / 2 - 15, 10, 30, 30)];
    [addBtn setImage:[UIImage imageNamed:@"+"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(clickAdd:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:addBtn];
    [self.view addSubview:_bottomView];
}

- (void)clickAdd:(UIButton *)button {
    PostCommoViewController * pcvc = [[PostCommoViewController alloc]init];
    [self presentViewController:pcvc animated:YES completion:nil];
}

#pragma mark - tableview手势滑动的监听

- (void)upGestureAction {
    [UIView animateWithDuration:0.1 delay:0.0 options:1 animations:^{
        _bottomView.frame = CGRectMake(0, winSize.size.height - 50, winSize.size.width, 50);
    } completion:nil];
}

- (void)downGestureAction {
    [UIView animateWithDuration:0.1 delay:0.0 options:1 animations:^{
        _bottomView.frame = CGRectMake(0, winSize.size.height, winSize.size.width, 0);
    } completion:nil];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y - _oldPointY > 5) {
        [self downGestureAction];
        _oldPointY = scrollView.contentOffset.y;
    }else if (scrollView.contentOffset.y - _oldPointY < -5) {
        [self upGestureAction];
        _oldPointY = scrollView.contentOffset.y;
    }
    NSLog(@"contentoffset.y %f",scrollView.contentOffset.y);
    NSLog(@"oldPointY%f ",_oldPointY);
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - tableView Delegate && DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * certif = @"CommoListCell";
    UINib * nib = [UINib nibWithNibName:certif bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:certif];
    CommoListCell * clc = [tableView dequeueReusableCellWithIdentifier:certif];
    if (clc == nil) {
        clc = [[CommoListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif];
    }
    clc.selectionStyle = UITableViewCellSelectionStyleNone;
    return clc;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 5)];
    footerView .backgroundColor = [UIColor colorWithRed:38.0/255 green:77.0/255 blue:100.0/255 alpha:1];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

@end
