//
//  BidViewController.m
//  Commo
//
//  Created by wuhaibin on 15/12/12.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import "BidViewController.h"
#import "BidScrollViewCell.h"
#import "BidTextViewCell.h"

#define winSize [[UIScreen mainScreen]bounds]

@interface BidViewController ()

@end

@implementation BidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBgView];
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)initBgView {
    self.bgView.backgroundColor = [UIColor colorWithRed:38.0/255 green:77.0/255 blue:100.0/255 alpha:1];
}

#pragma mark - tableView delegate && dataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * certif = @"BidScrollViewCell";
    UINib * nib = [UINib nibWithNibName:certif bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"BidScrollViewCell"];
    BidScrollViewCell * bsvc = [tableView dequeueReusableCellWithIdentifier:@"BidScrollViewCell"];
    return bsvc;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if ((winSize.size.height - 130 - 100)/5 *3  > 240) {
            return (winSize.size.height - 130 - 100)/5 * 3;
        }else {
            return  240;
        }
    }else {
        return (winSize.size.height - 130 - 100)/5 * 2;
    }
}

@end
