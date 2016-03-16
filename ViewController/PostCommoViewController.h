//
//  PostCommoViewController.h
//  Commo
//
//  Created by wuhaibin on 15/12/9.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommoDetailCell.h"
#import "AGIPCGridItem.h"

@interface PostCommoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CommentDetailCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AGIPCGridItemDelegate>

//@property (strong, nonatomic)id<CommentDetailCellDelegate> delegate;

@property (strong, nonatomic) NSMutableArray * picArray;

@end
