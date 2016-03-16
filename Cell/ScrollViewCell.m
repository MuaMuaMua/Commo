//
//  ScrollViewCell.m
//  Commo
//
//  Created by wuhaibin on 15/12/11.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import "ScrollViewCell.h"

@implementation ScrollViewCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)initArray {
    self.picArray = [[NSMutableArray alloc]init];
}

- (void)layoutSubviews {
    //设置 scrollview的一些属性.
//    self.scrollView.delegate = self;
//    self.scrollView.contentSize = CGSizeMake(200, 200);
    [self initArray];
    [self initScrolView];
}

- (void)initScrolView {
    for (int i = 0; i < 3; i ++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * 200, 0, 200, 200)];
        imageView.image = [UIImage imageNamed:@"GEM.邓紫棋"];
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
