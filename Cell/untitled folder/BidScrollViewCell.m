//
//  BidScrollViewCell.m
//  Commo
//
//  Created by wuhaibin on 15/12/12.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import "BidScrollViewCell.h"

@implementation BidScrollViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)initImageArray {
    self.imageArray = [[NSMutableArray alloc]init];
}

- (void)layoutSubviews {
    [self initScrollView];
}

- (void)initScrollView {
    
    for (int i = 0; i < 3; i ++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * 200, 0, 200, 200)];
        imageView.image = [UIImage imageNamed:@"CLOT"];
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(3 * 200, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.showsVerticalScrollIndicator = YES;
    self.scrollView.bounces = YES;
    self.scrollView.delegate = self;
}

@end
