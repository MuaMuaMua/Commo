//
//  CommoManager.h
//  Commo
//
//  Created by wuhaibin on 15/12/17.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Commo.h"

@interface CommoManager : NSObject

+ (CommoManager *) sharedInstance;

- (id) init;

- (Commo *)getCommoById:(NSString *)commoId;

@end
