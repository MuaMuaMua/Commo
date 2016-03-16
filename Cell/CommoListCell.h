//
//  CommoListCell.h
//  Commo
//
//  Created by wuhaibin on 15/12/12.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommoListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *IconView;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) UIImageView *coverImage;

@property (strong, nonatomic) UITextView *textView;

@property (strong, nonatomic) IBOutlet UILabel *valueLabel;

@property (strong, nonatomic) IBOutlet UILabel *periodLabel;

@end
