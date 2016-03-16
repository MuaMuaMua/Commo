//
//  CommoDetailCell.h
//  Commo
//
//  Created by wuhaibin on 15/12/9.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentDetailCellDelegate <NSObject>

- (void)clickAddAcion;

@end

@interface CommoDetailCell : UITableViewCell

@property (strong, nonatomic) UITextView * contentTextField;
@property (strong, nonatomic) NSMutableArray * picArray;
@property (strong, nonatomic) UIButton * addBtn;
@property (assign, nonatomic) id<CommentDetailCellDelegate> delegate;

@property (strong, nonatomic) UIImageView * imageView1;
@property (strong, nonatomic) UIImageView * imageView2;
@property (strong, nonatomic) UIImageView * imageView3;
@property (strong, nonatomic) UIImageView * imageView4;
@property (strong, nonatomic) UIImageView * imageView5;
@property (strong, nonatomic) UIImageView * imageView6;
@property (strong, nonatomic) UIImageView * imageView7;
@property (strong, nonatomic) UIImageView * imageView8;
@property (strong, nonatomic) UIImageView * imageView9;

- (void)initAddBtn;

- (void)reloadImageViews;
//不如先初始化了 9张图片的位置

@end
