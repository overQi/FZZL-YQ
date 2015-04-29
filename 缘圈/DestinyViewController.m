//
//  DestinyViewController.m
//  缘圈
//
//  Created by 徐 阳 on 15/4/26.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "DestinyViewController.h"
#import "UserModel.h"
#import "MJLockView.h"
#import "HP_Common4IOS.h"
#import "NSObject+Common4IOS_Animation.h"
#import "DSNavigationBar.h"
#import "UIImage+Common4IOS.h"
#import "NSString+Common4IOS.h"


@interface DestinyViewController ()<BaseViewControllerDelegate,MJLockViewDelegate>
@property (strong, nonatomic) IBOutlet MJLockView *lockView;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageInbottom;

@end

@implementation DestinyViewController
#pragma mark 懒加载


#pragma mark 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

#pragma mark 自定义函数
- (void)setupUI
{
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: [NSString addPrefix:[NSDate isDayOrNight] withString:@"背景-02"]]];
    
    //设置导航栏样式
    UIImage *image = [UIImage getImageFromColor:[UIColor clearColor]];
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationController.title = @"缘圈";
    
    self.lockView.frame = CGRectMake(10, MainHeight/2-MainWidth/2, MainWidth-20, MainWidth-20);

    
}
#pragma mark 代理
- (void)lockView:(MJLockView *)lockView didFinishPath:(NSString *)path
{
    FZ_LOG(@"%@",path);
}


@end
