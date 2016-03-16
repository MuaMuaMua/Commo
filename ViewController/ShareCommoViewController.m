//
//  ShareCommoViewController.m
//  Commo
//
//  Created by wuhaibin on 15/12/11.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import "ShareCommoViewController.h"

#import "ScrollViewCell.h"
#import "DeleteCell.h"
#import "TextViewCell.h"

#define winSize [[UIScreen mainScreen]bounds]

@interface ShareCommoViewController (){
    
    IBOutlet UITableView *_tableView;
    
    IBOutlet UIButton *_shareBtn;
    
    IBOutlet UILabel *_valueLabel;
    
    IBOutlet UILabel *_periodLabel;
    
    IBOutlet UIView *_bgView;
    
    CGFloat totalHeightForCell;
}

@end

@implementation ShareCommoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    totalHeightForCell = winSize.size.height - 230;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tableview Delegate && DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UINib * nib1 = [UINib nibWithNibName:@"ScrollViewCell" bundle:nil];
    [tableView registerNib:nib1 forCellReuseIdentifier:@"ScrollViewCell"];
    
    UINib * nib2 = [UINib nibWithNibName:@"DeleteCell" bundle:nil];
    [tableView registerNib:nib2 forCellReuseIdentifier:@"DeleteCell"];
    
    UINib * nib3 = [UINib nibWithNibName:@"TextViewCell" bundle:nil];
    [tableView registerNib:nib3 forCellReuseIdentifier:@"TextViewCell"];
    
    if (indexPath.row == 0) {
        ScrollViewCell * svc = [tableView dequeueReusableCellWithIdentifier:@"ScrollViewCell"];
        if (svc == nil) {
            svc = [[ScrollViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ScrollViewCell"];
        }
        svc.selected = NO;
        return svc;
    }else if (indexPath.row == 1){
        DeleteCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DeleteCell"];
        if ( cell == nil) {
            cell = [[DeleteCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DeleteCell"];
        }
        cell.selected = NO;
        return cell;
    }else if (indexPath.row == 2){
        TextViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TextViewCell"];
        if ( cell == nil) {
            cell = [[TextViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TextViewCell"];
        }
        cell.selected = NO;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 240;
    }else if (indexPath.row == 1) {
        return 50;
    }else if (indexPath.row == 2) {
        return 50;//暂时 设定为 50  之后再按照textview的效果算
    }
    return 0;
}

@end
