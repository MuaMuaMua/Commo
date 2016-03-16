//
//  PostCommoViewController.m
//  Commo
//
//  Created by wuhaibin on 15/12/9.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import "PostCommoViewController.h"
#import "CommoInfoCell.h"
#import "CommoDetailCell.h"
#import "AGImagePickerController.h"
#import "AGIPCToolbarItem.h"
#import "AGIPCPreviewController.h"
#import "AGIPCGridItem.h"

#define winSize [[UIScreen mainScreen]bounds]
#define pictureWidth (winSize.size.width - 35) / 4

@interface PostCommoViewController (){

    IBOutlet UITableView *_tableView;
    
    IBOutlet UINavigationBar *_navigationBar;
    
    CommoDetailCell * _commoDetailCell;
    
    NSMutableArray * _picArray;
    
    NSMutableArray * _cellTitleArray;
    
    AGImagePickerController * _ipc;
    
    AGIPCPreviewController * _agIpc;
    
    NSMutableArray * _assetArray;
    
    UIView * _contentImageView;

    UIButton * _addBtn;
}

@end

@implementation PostCommoViewController

- (void)initTitleArray {
    NSString * title1 = @"BEGIN";
    NSString * title2 = @"PERIOD";
    NSString * title3 = @"EVERY BID";
    
    _cellTitleArray = [[NSMutableArray alloc]initWithObjects:title1,title2,title3, nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAGImagePickerController];
    [self initTitleArray];
    //设置返回的 object的值 是int型的具体的下标索引。
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteImage:) name:@"deleteImage" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshImage) name:@"RefreshImage" object:nil];
    [self navigationBarSetting];
    [self initTableView];
    
}

#pragma mark - 通知传送

- (void)deleteImage:(NSNotification *)notification {
    NSDictionary * dictionary = [notification userInfo];
    NSLog(@"%@",[dictionary objectForKey:@"index"]);
    NSNumber * number = [dictionary objectForKey:@"index"];
    NSInteger indexKey = [number integerValue];
    [self.picArray removeObjectAtIndex:indexKey];
    
    //
//    _assetArray = [[NSMutableArray alloc]initWithArray:self.picArray];
    [_assetArray removeObjectAtIndex:indexKey];
    [self refreshImage];
}

#pragma mark - 初始化 AGIPCPreviewController 

- (void)clickPreView:(UIButton *)sender{
    UIButton * button = sender;
    NSLog(@"%ld",(long)sender.tag);
    [self initAGIPCPreviewController:sender.tag];
}

- (void)initAGIPCPreviewController:(int)targetInt{
    _agIpc = [[AGIPCPreviewController alloc]initWithAssets:_assetArray targetInt:targetInt];
    _agIpc.isSelectView = NO;
    [self presentViewController:_agIpc animated:YES completion:nil];
}

- (void)initAGIPCGridItem :(int)index {
    AGIPCGridItem *gridItem = [[AGIPCGridItem alloc] initWithImagePickerController:_ipc asset:[_picArray objectAtIndex:index] andDelegate:self];
    [_assetArray addObject:gridItem];
}

#pragma mark - 初始化 第三方imagepicker

- (void)initAGImagePickerController {
    _ipc = [AGImagePickerController sharedInstance:self];
    
    self.picArray = [[NSMutableArray alloc]init];
    
    _assetArray = [[NSMutableArray alloc]init];
    
    __block PostCommoViewController * blockSelf = self;
    
    _ipc.didFinishBlock = ^(NSArray *info) {
        NSLog(@"%@",info);
        blockSelf.picArray = [[NSMutableArray alloc]init];
        [blockSelf.picArray setArray:info];
        [blockSelf dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshImage" object:nil];
    };
}

//清除上面所有的控件 而不是单纯地加控件
- (void)refreshImage {
    
    //去掉 在_contentImageView 上面的 每一个 button
    for (UIButton * singleView in _contentImageView.subviews) {
        if ([singleView isKindOfClass:[UIButton class]]) {
            [singleView removeFromSuperview];
        }
    }
    
    //去除图层
    [_contentImageView removeFromSuperview];
    
    //重新初始化 _assetArray  和 _contentImageView
    _assetArray = [[NSMutableArray alloc]init];
    if (_picArray.count <=3 ){
        _contentImageView = [[UIView alloc]initWithFrame:CGRectMake(0, 95, winSize.size.width, 100)];
    }else if(_picArray.count <= 7) {
        _contentImageView = [[UIView alloc]initWithFrame:CGRectMake(0, 95, winSize.size.width, (pictureWidth + 5) * 2)];
    }else {
        _contentImageView = [[UIView alloc]initWithFrame:CGRectMake(0, 95, winSize.size.width, (pictureWidth + 5)*3)];
    }
//    _contentImageView = [[UIView alloc]initWithFrame:CGRectMake(0, 95, winSize.size.width, 100)];
    for (int i = 0; i < _picArray.count;  i ++) {
        UIImage * image;
        if ([[_picArray objectAtIndex:i]isKindOfClass: [ALAsset class]]) {
            ALAsset * asset = [_picArray objectAtIndex:i];
            CGRect rect = CGRectMake(0, 100, 320, 320);
            CGImageRef imageRef = CGImageCreateWithImageInRect(asset.aspectRatioThumbnail, rect);
            image = [UIImage imageWithCGImage:imageRef];
        }
        //初始化 图片button
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(10 +(5 + pictureWidth)*(i%4), (i/4)*(pictureWidth + 5), pictureWidth, pictureWidth)];
        [button setImage:image forState:UIControlStateNormal];
        button.tag = i;
        [self initAGIPCGridItem:i];
        [button addTarget:self action:@selector(clickPreView:) forControlEvents:UIControlEventTouchUpInside];
        [_contentImageView addSubview:button];
        
        //当 i 是最后一个 count 的时候  需要在上面加上addBtn
        if (i == _picArray.count - 1 && _picArray.count != 9) {
            [_addBtn removeFromSuperview];
            int j = i + 1;
            _addBtn = [[UIButton alloc]initWithFrame:CGRectMake(10 +(5 + pictureWidth)*(j%4), (j/4)*(pictureWidth + 5), pictureWidth, pictureWidth)];
            [_addBtn setImage:[UIImage imageNamed:@"RectAndPlus"] forState:UIControlStateNormal];
            [_addBtn addTarget:self action:@selector(clickAddAcion) forControlEvents:UIControlEventTouchUpInside];
            [_contentImageView addSubview:_addBtn];
        }
    }
    if (_picArray.count == 0) {
        _addBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, pictureWidth, pictureWidth)];
        [_addBtn setImage:[UIImage imageNamed:@"RectAndPlus"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(clickAddAcion) forControlEvents:UIControlEventTouchUpInside];
        [_contentImageView addSubview:_addBtn];
    }
    [_commoDetailCell.contentView addSubview:_contentImageView];
    [_tableView reloadData];
}

- (void)initTableView {
    _commoDetailCell = [[CommoDetailCell alloc]init];
    _commoDetailCell.delegate = self;
    [_commoDetailCell initAddBtn];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:36.0/255 green:77.0/255 blue:101.0/255 alpha:1];
}

//- (void)

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)navigationBarSetting {
    _navigationBar.barTintColor = [UIColor colorWithRed:59.0/255 green:58.0/255 blue:63.0/255 alpha:1];
}

#pragma mark - tableView delegate&& dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * certif = @"InfoCell";
    UINib * nib = [UINib nibWithNibName:@"CommoInfoCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:certif];
    if(indexPath.section == 0 && indexPath.row == 0){
        return _commoDetailCell;
    }else {
        CommoInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:certif];
        if (cell == nil) {
            cell = [[CommoInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif];
        }
        cell.titleField.placeholder = [_cellTitleArray objectAtIndex:indexPath.row];
        return cell;
    }
    return _commoDetailCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        //如果是只有一层  四张以内 就是 返回 95 + tupian kuan du + 5
        if (_picArray.count <= 3) {
            return 95 + pictureWidth + 5 ;
        }else if (_picArray.count <= 7) {
            return 95 + (pictureWidth + 5)*2;
        }else {
            return 95 + (pictureWidth + 5)*3;
        }
    }else {
        return 40;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10.0f;
    }else {
        return 0;//尽量高一点 以免 下拉的时候露出空白的位置.
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * footView = [[UIView alloc]init];
    if (section == 0) {
        footView.frame = CGRectMake(0, 0, self.view.frame.size.width, 10);
    }else {
        footView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    footView.backgroundColor = [UIColor colorWithRed:36.0/255 green:77.0/255 blue:101.0/255 alpha:1];
    return footView;
}

- (void)clickAddAcion {
    //新的 agimagepickerContorller的 添加图片f
    
//    _ipc = [AGImagePickerController sharedInstance:self];
    
    
    _ipc = [[AGImagePickerController alloc]initWithDelegate:self];
    
    _ipc.shouldShowSavedPhotosOnTop = NO;
    _ipc.shouldChangeStatusBarStyle = NO;
    _ipc.selection = self.picArray;
    _ipc.maximumNumberOfPhotosToBeSelected = 9 - self.picArray.count;
    
    __block PostCommoViewController * blockSelf = self;

    _ipc.didFinishBlock = ^(NSArray *info) {
        NSLog(@"%@",info);
//        blockSelf.picArray = [[NSMutableArray alloc]init];
        for (int i = 0; i < info.count; i ++ ) {
            [blockSelf.picArray addObject:[info objectAtIndex:i]];
        }
        [blockSelf dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshImage" object:nil];
    };
    
    UIButton * toolBarLeftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
    [toolBarLeftBtn setTitle:@"预览" forState:UIControlStateNormal];
    [self presentViewController:_ipc animated:YES completion:nil];
    
}

- (void)reloadImageView{

}

- (IBAction)cancelBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendBtnAction:(id)sender {
    //未处理发送功能. 后台功能未实现
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //通过UIImagePickerControllerMediaType判断返回的是照片还是视频
    NSString* type = [info objectForKey:UIImagePickerControllerMediaType];
    //如果返回的type等于kUTTypeImage，代表返回的是照片,并且需要判断当前相机使用的sourcetype是拍照还是相册
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_picArray addObject:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"RefreshImage" object:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"RefreshImage" object:nil];
}

@end
