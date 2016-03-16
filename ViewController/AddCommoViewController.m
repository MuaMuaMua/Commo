//
//  AddCommoViewController.m
//  Commo
//
//  Created by wuhaibin on 15/12/9.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import "AddCommoViewController.h"

@interface AddCommoViewController ()

@end

@implementation AddCommoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBackground];
    [self.addBtn addTarget:self action:@selector(clickAddAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}

- (void)initBackground {
    self.view.backgroundColor = [UIColor colorWithRed:38.0/255 green:77.0/255 blue:100.0/255 alpha:1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickAddAction {
    
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
