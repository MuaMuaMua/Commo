//
//  ScrollViewCell.h
//  Commo
//
//  Created by wuhaibin on 15/12/11.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewCell : UITableViewCell <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSMutableArray * picArray;

@end
