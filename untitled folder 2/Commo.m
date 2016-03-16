//
//  Commo.m
//  Commo
//
//  Created by wuhaibin on 15/12/17.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import "Commo.h"

@implementation Commo

+ (Commo *) getinstance {
    static Commo *_instance = nil;
    
    @synchronized(self){
        if (!_instance){
            _instance = [[Commo alloc] init];
            return _instance;
        }
    }
    
    return _instance;
}

- (id) init{
    if (self = [super init]){
        //在此处进行初始化设置
    }
    return self;
}


@end
