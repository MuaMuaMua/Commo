//
//  CommoDetailCell.m
//  Commo
//
//  Created by wuhaibin on 15/12/9.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import "CommoDetailCell.h"

#define winSize [[UIScreen mainScreen]bounds]

#define pictureWidth (winSize.size.width - 35) / 4

@implementation CommoDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)layoutSubviews {
//    [self initAddBtn];
    [self initTextField];
}

#pragma mark - 初始化图片

- (void)reloadData {
    //怎么初始化 这组图片 看返回的数据的个数。
}

- (void)initImageViews {
    self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 95, pictureWidth, pictureWidth)];
    self.imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(10 + 5 + pictureWidth , 95, pictureWidth, pictureWidth)];
    self.imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (5 + pictureWidth)*2 , 95, pictureWidth, pictureWidth)];
    self.imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (5 + pictureWidth)*3 , 95, pictureWidth, pictureWidth)];
    
    self.imageView5 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 95 + (5 + pictureWidth), pictureWidth, pictureWidth)];
    self.imageView6 = [[UIImageView alloc]initWithFrame:CGRectMake(10 + 5 + pictureWidth , 95 + (5 + pictureWidth), pictureWidth, pictureWidth)];
    self.imageView7 = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (5 + pictureWidth)*2 , 95 + (5 + pictureWidth), pictureWidth, pictureWidth)];
    self.imageView8 = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (5 + pictureWidth)*3 , 95 + (5 + pictureWidth), pictureWidth, pictureWidth)];
    
}

#pragma mark - 初始化 AddBtn

- (void)initAddBtn {
    self.addBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 95, pictureWidth, pictureWidth)];
    [self.addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.addBtn setImage:[UIImage imageNamed:@"RectAndPlus"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.addBtn];
}

#pragma mark - 初始化图片的数组 以及重新调整最多九张图片的View

- (void)initPicArray {
    
}

- (void)initTextField {
    self.contentTextField = [[UITextView alloc]initWithFrame:CGRectMake(0, 5, winSize.size.width - 10, 80)];
    [self.contentView addSubview:self.contentTextField];
}

- (void)reloadImageViews{
//    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(10 + 5 + pictureWidth , 95, pictureWidth, pictureWidth)];
//    [button setImage:[UIImage imageNamed:@"RectAndPlus"] forState:UIControlStateNormal];
//    [self.contentView addSubview:button];
    
}

- (void)addBtnAction {
    [self.delegate clickAddAcion];
}


@end
