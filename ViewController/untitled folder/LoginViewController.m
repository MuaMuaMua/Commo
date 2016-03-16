//
//  LoginViewController.m
//  Commo
//
//  Created by wuhaibin on 15/12/12.
//  Copyright © 2015年 wuhaibin. All rights reserved.
//

#import "LoginViewController.h"
#import "CommoListViewController.h"


#define winSize [[UIScreen mainScreen]bounds]

@interface LoginViewController () {
    UIView * _bottomView;
    UIButton * _plusBtn;
    NSTimer * _timer;
    int _second;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeContentViewPoint:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeContentViewPoint:) name:UIKeyboardWillHideNotification object:nil];
    self.type = 1;
    _second = 60;
    [self initBgView];
    [self initBottomView];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(initTapGesture)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
}

// 根据键盘状态，调整_mainView的位置
- (void) changeContentViewPoint:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndY = value.CGRectValue.origin.y;  // 得到键盘弹出后的键盘视图所在y坐标
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // 添加移动动画，使视图跟随键盘移动
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        self.view.center = CGPointMake(self.view.center.x, keyBoardEndY - self.view.bounds.size.height/2.0);   // keyBoardEndY的坐标包括了状态栏的高度，要减去
    }];
}

- (void)initTextField {
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.textColor = [UIColor blackColor];
    self.textField.font = [UIFont systemFontOfSize:20];
//    [self.textField setValue:[UIColor colorWithRed:170.0/255 green:170.0/255 blue:170.0/255 alpha:1] forKey:@"_placeholderLabel.textColor"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initTapGesture {
    [self.textField resignFirstResponder];
}

- (void)initBgView {
    self.view.backgroundColor = [UIColor colorWithRed:38.0/255 green:77.0/255 blue:100.0/255 alpha:1];
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)initBottomView {
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, winSize.size.height - 50, winSize.size.width, 50)];
    _bottomView.backgroundColor = [UIColor blackColor];
    _plusBtn = [[UIButton alloc]initWithFrame:CGRectMake( 30, 13, winSize.size.width - 60, 24)];
    [_plusBtn setTitle:@"SEND CODE" forState:UIControlStateNormal];
    [_plusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_plusBtn setFont:[UIFont systemFontOfSize:20]];
    [_bottomView addSubview:_plusBtn];
    [_plusBtn addTarget:self action:@selector(clickSendBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)sendNumber {
    // 发送短信验证的接口 未写完
}

#pragma mark - 初始化  计时器

- (void)initTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timePast) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)timePast {
    NSString * secondString = [NSString stringWithFormat:@"%d S",_second];
    _second -- ;
    [_plusBtn setTitle:secondString forState:UIControlStateNormal];
}

- (void)clickSendBtn {
    //设置 如果num 是正确的 返回的值
    if (self.type == 1) {
        self.type = 2;
        self.titleLabel.text = @"COMMO";
        [self.textField setText:@""];
        [_plusBtn setTitle:@"60S" forState:UIControlStateNormal];
        [self initTimer];
        self.textField.placeholder = @"YOUR VERTIFY CODE";
        [self.textField resignFirstResponder];
    }
    else if (self.type == 2) {
        CommoListViewController * clvc = [[CommoListViewController alloc]init];
        
        [self presentViewController:clvc animated:YES completion:nil];
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    NSLog(@"%@",self.textField.text);
    if (textField.text.length == 11 && self.type != 2) {
        [self.view addSubview:_bottomView];
    }else {
        if (self.type == 2) {
            
        }else {
            [_bottomView removeFromSuperview];
        }
    }
}

@end
