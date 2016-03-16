//
//  Commo.h
//  Commo
//
//  Created by wuhaibin on 15/12/11.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Commo : NSObject

@property (strong, nonatomic) NSString * commoId;

@property (strong, nonatomic) NSMutableArray * picArray;

@property (strong, nonatomic) NSString * shareInfo;

@property int value;       //价格

@property int currentValue;

@property int everyBid;    //最小单位  之后再算

@property NSTimeInterval * period;     //时间间隔

@property (strong, nonatomic) NSString * type;

@property (strong, nonatomic) NSString * senderId;

@end
