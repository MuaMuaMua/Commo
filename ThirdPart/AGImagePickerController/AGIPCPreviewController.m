//
//  AGIPCPreviewController.m
//  AGImagePickerController Demo
//
//  Created by SpringOx on 14/11/1.
//  Copyright (c) 2014年 Artur Grigor. All rights reserved.
//

#import "AGIPCPreviewController.h"

#import "AGIPCGridItem.h"
#import "AGPreviewScrollView.h"
#import "AGImagePreviewController.h"
#import "UIButton+AGIPC.h"

@interface AGIPCPreviewController ()<AGPreviewScrollViewDelegate> {
    UINavigationBar * _navigationBar;
    BOOL _tap;
}

@property (nonatomic, strong) AGPreviewScrollView *preScrollView;

@property (nonatomic, strong) UIView *bottomBgView;

@property (nonatomic, strong) UIButton *bottomLeftBtn;

@property (nonatomic, strong) UIButton *bottomMiddleBtn;

@property (nonatomic, strong) UIButton *bottomRightBtn;

@end

@implementation AGIPCPreviewController

- (id)initWithAssets:(NSArray *)assets targetAsset:(AGIPCGridItem *)targetAsset
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _targetType = 1;
        self.isSelectView = YES;
        _assets = assets;
        _targetAsset = targetAsset;
    }
    return self;
}

- (id)initWithAssets:(NSArray *)assets targetInt:(int)targetInt {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _targetType = -1;
        self.isSelectView = NO;
        _assets = assets;
        _targetInt = targetInt;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tap = true;
    [self initNavigationBar];
    // Do any additional setup after loading the view.
    
    [self setTopView];
    [self setScrollView];
}

- (void)initNavigationBar  {
    
}

- (void)clickTap {
    if (_tap) {
        _tap = false;
        [UIView animateWithDuration:0.2 delay:0.0 options:1 animations:^{
            _bottomBgView.frame = CGRectMake(0, 0, self.view.frame.size.width, 64);
        } completion:nil];
    }else {
        _tap = true;
        [UIView animateWithDuration:0.2 delay:0.0 options:1 animations:^{
            _bottomBgView.frame = CGRectMake(0, -64, self.view.frame.size.width, 64);
        } completion:nil];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
//    [self setBottomView];
    
    [self setScrollView];
    
    [_preScrollView resetContentViews];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    if ([_delegate respondsToSelector:@selector(previewController:didRotateFromOrientation:)]) {
        [_delegate previewController:self didRotateFromOrientation:fromInterfaceOrientation];
    }
}

- (void)setTopView {

    _bottomBgView = [[UIView alloc]init];
    _bottomBgView.backgroundColor = [UIColor colorWithRed:59.0/255 green:58.0/255 blue:63.0/255 alpha:1];
    _bottomBgView.frame = CGRectMake(0, -64, self.view.frame.size.width, 64);
    [self.view addSubview:_bottomBgView];
    
    if (nil == _bottomLeftBtn) {
        /*Left Top Button*/
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.backgroundColor = [UIColor clearColor];
        [leftBtn setImage:[UIImage imageNamed:@"AGImagePickerController.bundle/AGIPC-Bar-back"] forState:UIControlStateNormal];
        leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
        [leftBtn addTarget:self action:@selector(didPressBottomLeftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _bottomLeftBtn = leftBtn;
    }
    _bottomLeftBtn.frame = CGRectMake(0, 20, 120, 44);
    [_bottomBgView addSubview:_bottomLeftBtn];
//    _bottomRightBtn.frame = CGRectMake(_bottomBgView.frame.size.width-70, 20, 90, 44);
//    [_bottomBgView addSubview:_bottomRightBtn];
        if (self.targetType == -1) {
            if (nil == _bottomRightBtn) {
                UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                deleteBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
                [deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
                deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                [deleteBtn addTarget:self action:@selector(deleteView) forControlEvents:        UIControlEventTouchUpInside];
                _bottomRightBtn = deleteBtn;
                _bottomRightBtn.frame = CGRectMake(_bottomBgView.frame.size.width-70, 20, 90, 44);
            }
        }else {
            if (nil == _bottomRightBtn) {
                /*Right Top Button*/
                UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                rightBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
                rightBtn.backgroundColor = [UIColor clearColor];
                [rightBtn setImage:[UIImage imageNamed:@"AGImagePickerController.bundle/AGIPC-Checkmark-0"] forState:UIControlStateNormal];
                rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                [rightBtn addTarget:self action:@selector(didPressBottomRightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                _bottomRightBtn = rightBtn;
                _bottomRightBtn.frame = CGRectMake(_bottomBgView.frame.size.width-70, 20, 90, 44);
            }
        }
    [_bottomBgView addSubview:_bottomRightBtn];
        
    
}

- (void)deleteView {
    
    NSInteger index = [_preScrollView currentIndexOfImage];
    NSLog(@"%ld",(long)index);
//    self
//    self.assets
    NSArray * newArray = [[NSArray alloc]init];
    NSMutableArray * sssArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.assets.count; i++) {
        if (i != index) {
            [sssArray addObject:[self.assets objectAtIndex:i]];
        }
    }
    self.assets = [[NSArray alloc]initWithArray:sssArray];
    [_preScrollView removeFromSuperview];
    _preScrollView = [[AGPreviewScrollView alloc] initWithFrame:self.view.bounds preDelegate:self];
    
    _preScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _preScrollView.bounces = NO;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapGestureRecognizer)];
    tapGesture.numberOfTapsRequired = 2;
    [_preScrollView addGestureRecognizer:tapGesture];
    UITapGestureRecognizer * oneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap)];
    oneTap.numberOfTapsRequired = 1;
    [_preScrollView addGestureRecognizer:oneTap];
    NSNumber * number = [NSNumber numberWithInteger:index];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteImage" object:self userInfo:@{@"index":number}];
    if (self.assets.count != 0) {
        [_preScrollView removeFromSuperview];
//        _preScrollView.currentIndexOfImage = index - 1;
        [self.view insertSubview:_preScrollView belowSubview:_bottomBgView];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setScrollView
{
    if (nil == _preScrollView) {
        _preScrollView = [[AGPreviewScrollView alloc] initWithFrame:self.view.bounds preDelegate:self];
        _preScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _preScrollView.bounces = NO;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapGestureRecognizer)];
        tapGesture.numberOfTapsRequired = 2;
        [_preScrollView addGestureRecognizer:tapGesture];
        UITapGestureRecognizer * oneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap)];
        oneTap.numberOfTapsRequired = 1;
        [_preScrollView addGestureRecognizer:oneTap];
    }
    [self.view insertSubview:_preScrollView belowSubview:_bottomBgView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateBottomRightButtonState:(int)state
{
    if(self.targetType == -1) {
        
    }else {
    if (2 == state) {  // with animation
        [_bottomRightBtn setImageWithAnimation:[UIImage imageNamed:@"AGImagePickerController.bundle/AGIPC-Checkmark-1"] forState:UIControlStateNormal];
    } else if (1 == state) {  // without animation
        [_bottomRightBtn setImage:[UIImage imageNamed:@"AGImagePickerController.bundle/AGIPC-Checkmark-1"] forState:UIControlStateNormal];
    } else {
        [_bottomRightBtn setImage:[UIImage imageNamed:@"AGImagePickerController.bundle/AGIPC-Checkmark-0"] forState:UIControlStateNormal];
    }
    }
}

- (void)didTapGestureRecognizer
{
    [self didPressBottomLeftButtonAction:nil];
}

- (void)didPressBottomLeftButtonAction:(id)sender
{
    if (nil != self.navigationController && 1 < [self.navigationController.viewControllers count]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (void)didPressBottomMiddleButtonAction:(id)sender
{
    NSInteger index = [_preScrollView currentIndexOfImage];
    if ([_assets count] <= index) {
        return;
    }
    AGIPCGridItem *gridItem = [_assets objectAtIndex:index];
    ALAsset *asset = gridItem.asset;
    UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
    AGImagePreviewController *preController = [[AGImagePreviewController alloc] initWithImage:image];
    preController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:preController animated:YES completion:^{
    }];
}

- (void)didPressBottomRightButtonAction:(id)sender
{

    if (self.targetType == -1) {
        
    }else {
    NSInteger index = _preScrollView.currentIndexOfImage;
    if ([_assets count] <= index) {
        return;
    }
    AGIPCGridItem *gridItem = [_assets objectAtIndex:index];
    gridItem.selected = !gridItem.selected;
    if (gridItem.selected) {
        [self updateBottomRightButtonState:2];
    } else {
        [self updateBottomRightButtonState:0];
    }
    }
}

#pragma mark - AGPreviewScrollViewDelegate

- (NSInteger)previewScrollViewNumberOfImage:(AGPreviewScrollView *)scrollView{
    return [_assets count];
}

- (CGSize)previewScrollViewSizeOfImage:(AGPreviewScrollView *)scrollView{
    return self.view.bounds.size;
}

- (NSUInteger)previewScrollViewCurrentIndexOfImage:(AGPreviewScrollView *)scrollView{
    if (_targetAsset == nil){
        return _targetInt;
    }
    return [_assets indexOfObject:_targetAsset];
}

- (UIImage *)previewScrollView:(AGPreviewScrollView *)scrollView imageAtIndex:(NSUInteger)index
{
    if ([_assets count] <= index) {
        return nil;
    }
    
    AGIPCGridItem *gridItem = [_assets objectAtIndex:index];
    ALAsset *asset = gridItem.asset;
//    ALAsset * asset = [_assets objectAtIndex:index];
    UIImage *image = [UIImage imageWithCGImage:asset .defaultRepresentation.fullScreenImage];
    return image;
}

- (void)previewScrollView:(AGPreviewScrollView *)scrollView didScrollWithCurrentIndex:(NSUInteger)index
{
    if ([_assets count] <= index) {
        return;
    }
    
    AGIPCGridItem *gridItem = [_assets objectAtIndex:index];
    if (gridItem.selected) {
        [self updateBottomRightButtonState:1];
    } else {
        [self updateBottomRightButtonState:0];
    }
}

@end
