//
//  ViewController.h
//  Commo
//
//  Created by wuhaibin on 15/12/9.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGImagePickerController.h"

@interface ViewController : UIViewController<AGImagePickerControllerDelegate>

@property (strong, nonatomic) NSMutableArray * picArray;

@end

