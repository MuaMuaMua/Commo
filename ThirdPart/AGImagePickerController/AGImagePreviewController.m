//
//  AGImagePreviewController.m
//  Araneo
//
//  Created by SpringOx on 14-10-23.
//  Copyright (c) 2014年 SpringOx. All rights reserved.
//

#import "AGImagePreviewController.h"

@interface AGImagePreviewController (){
    UINavigationBar * _navigationBar;
    BOOL _tap;
}

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation AGImagePreviewController

- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}


- (void)initNavigationBar {
    
    _navigationBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, -64, self.view.frame.size.width, 64)];
    _navigationBar.backgroundColor = [UIColor colorWithRed:59.0/255 green:58.0/255 blue:63.0/255 alpha:1];
    [self.view addSubview:_navigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    _tap = true;
//    [self initNavigationBar];
    // Do any additional setup after loading the view.
    
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc] initWithImage:_image];
    }
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.bounces = NO;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapGestureRecognizer)];
        tapGesture.numberOfTapsRequired = 1;
        [_scrollView addGestureRecognizer:tapGesture];
        
//        UITapGestureRecognizer * oneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap)];
//        oneTap.numberOfTapsRequired = 1;
//        [_scrollView addGestureRecognizer:oneTap];
    }
    [self layoutViews];
}

//- (void)clickTap {
//    if (_tap) {
//        _tap = false;
//        [UIView animateWithDuration:0.2 delay:0.0 options:1 animations:^{
//            _navigationBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 64);
//        } completion:nil];
//    }else {
//        _tap = true;
//        [UIView animateWithDuration:0.2 delay:0.0 options:1 animations:^{
//            _navigationBar.frame = CGRectMake(0, -64, self.view.frame.size.width, 64);
//        } completion:nil];
//    }
//    
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    [self layoutViews];
}

- (void)layoutViews
{
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    if (UIInterfaceOrientationLandscapeLeft == self.interfaceOrientation ||
        UIInterfaceOrientationLandscapeRight == self.interfaceOrientation) {
        if (width < height) {
            CGFloat temp = width;
            width = height;
            height = temp;
        }
    }
    CGFloat tWidth = ceilf(height*_image.size.width/_image.size.height);
    CGFloat tHeight = ceilf(width*_image.size.height/_image.size.width);
    if (tWidth < width) {
        height = tHeight;
    } else {
        width = tWidth;
    }
    _imageView.frame = CGRectMake(0, 0, width, height);
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _scrollView.contentSize = _imageView.bounds.size;
    
    [_scrollView addSubview:_imageView];
    [self.view addSubview:_scrollView];
}

- (void)didTapGestureRecognizer
{
    if (nil != self.navigationController && 1 < [self.navigationController.viewControllers count]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissModalViewControllerAnimated:YES];
    }
}

@end
