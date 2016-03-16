//
//  BidViewController.h
//  Commo
//
//  Created by wuhaibin on 15/12/12.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BidViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *bgView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIButton *bidBtn;

@property (strong, nonatomic) IBOutlet UILabel *valueLabel;

@property (strong, nonatomic) IBOutlet UILabel *periodLabel;

@end
