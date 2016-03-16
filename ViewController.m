//
//  ViewController.m
//  Commo
//
//  Created by wuhaibin on 15/12/9.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import "ViewController.h"
#import "AddCommoViewController.h"
#import "PostCommoViewController.h"
#import "AGIPCToolbarItem.h"
#import "AGImagePickerController.h"
#import "ShareCommoViewController.h"
#import "CommoListViewController.h"
#import "LoginViewController.h"

#import "CommoUser.h"
#import "Commo.h"

#import "YTKKeyValueStore.h"


@interface ViewController () {
    AGImagePickerController * _ipc;
    YTKKeyValueStore * _kvs;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.picArray = [[NSMutableArray alloc]init];
    _ipc = [AGImagePickerController sharedInstance:self];
    __block ViewController * blockSelf = self;
    
    _ipc.didFinishBlock = ^(NSArray *info) {
        [blockSelf.picArray setArray:info];
        
        NSLog(@"Info: %@", info);
        [blockSelf dismissModalViewControllerAnimated:YES];
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    };    // Do any additional setup after loading the view, typically from a nib.
    [self initYTKKeyValueStore];
    [self initCommo];
    [self loadCommo];
}

- (void)initYTKKeyValueStore {
    _kvs = [[YTKKeyValueStore alloc]initDBWithName:@"CommoDB"];
    NSString *tableName = @"user_table";
    // 创建名为user_table的表，如果已存在，则忽略该操作
    [_kvs createTableWithName:tableName];
}

- (void)initCommo {
    Commo * commo = [[Commo alloc]init];
    commo.value = 50;
    commo.currentValue = 100;
    commo.shareInfo = @"测试一波YTKKeyvalueStore";
    NSMutableDictionary * testDictionary = [[NSMutableDictionary alloc]init];
    [testDictionary setObject:@"kkdkkdkdk" forKey:@"key1"];
    
    [_kvs putObject:testDictionary withId:@"dictions" intoTable:@"user_table"];
    [_kvs putString:commo.shareInfo withId:@"sss" intoTable:@"user_table"];
}

- (void)loadCommo {
    NSMutableDictionary * testDictionary = [[NSMutableDictionary alloc]init];
    testDictionary = [_kvs getObjectById:@"dictions" fromTable:@"user_table"];

    Commo * commo = [[Commo alloc]init];
    commo.shareInfo = [_kvs getStringById:@"sss" fromTable:@"user_table"];
    NSLog(@"%@",commo.shareInfo);
}

- (IBAction)clickB:(id)sender {
    ShareCommoViewController * scvc = [[ShareCommoViewController alloc]init];
    CommoListViewController * clvc = [[CommoListViewController alloc]init];
    
    [self presentViewController:clvc animated:YES completion:nil];
}

- (IBAction)clickC:(id)sender {
    _ipc.shouldShowSavedPhotosOnTop = NO;
    _ipc.shouldChangeStatusBarStyle = NO;
    _ipc.selection = self.picArray;
    _ipc.maximumNumberOfPhotosToBeSelected = 100;
    AGIPCToolbarItem *selectAll = [[AGIPCToolbarItem alloc] initWithBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"+ Select All" style:UIBarButtonItemStyleBordered target:nil action:nil] andSelectionBlock:^BOOL(NSUInteger index, ALAsset *asset) {
        return YES;
    }];
    AGIPCToolbarItem *flexible = [[AGIPCToolbarItem alloc] initWithBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] andSelectionBlock:nil];
    AGIPCToolbarItem *selectOdd = [[AGIPCToolbarItem alloc] initWithBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"+ Select Odd" style:UIBarButtonItemStyleBordered target:nil action:nil] andSelectionBlock:^BOOL(NSUInteger index, ALAsset *asset) {
        return !(index % 2);
    }];
    AGIPCToolbarItem *deselectAll = [[AGIPCToolbarItem alloc] initWithBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"- Deselect All" style:UIBarButtonItemStyleBordered target:nil action:nil] andSelectionBlock:^BOOL(NSUInteger index, ALAsset *asset) {
        return NO;
    }];
    _ipc.toolbarItemsForManagingTheSelection = @[selectAll, flexible, flexible, deselectAll];
    [self presentModalViewController:_ipc animated:YES];
}

- (IBAction)ClickLogin:(id)sender {
    LoginViewController * loginVC = [[LoginViewController alloc]init];
    [self presentViewController:loginVC animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
