//
//  CommoManager.m
//  Commo
//
//  Created by wuhaibin on 15/12/17.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import "CommoManager.h"
#import "YTKKeyValueStore.h"
#import "CommoUser.h"

@implementation CommoManager{
    YTKKeyValueStore * _kvs;
}

+ (CommoManager *) sharedInstance {
    static CommoManager *_instance = nil;
    
    @synchronized(self){
        if (!_instance){
            _instance = [[CommoManager alloc] init];
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

- (Commo *)getCommoById:(NSString *)commoId {
    Commo * commo = [[Commo alloc]init];
    _kvs = [[YTKKeyValueStore alloc]initDBWithName:@"CommoDB"];
    NSString *tableName = @"Commo";
    // 创建名为user_table的表，如果已存在，则忽略该操作
    [_kvs createTableWithName:tableName];
    
    NSDictionary * commoDic = [_kvs getObjectById:commoId fromTable:tableName];

    return commo;
}

- (NSArray *)getCommoList:(NSString *)userId {
    _kvs = [[YTKKeyValueStore alloc]initDBWithName:@"CommoDB"];
    NSString * tableName = @"CommoList";
    [_kvs createTableWithName:tableName];
    NSArray * commoList = [_kvs getObjectById:userId fromTable:tableName];
    
    /* 
     *  commolist 里面存的是ID
     */
    return commoList;
}

- (void) getUserInfo {
    
}


@end
