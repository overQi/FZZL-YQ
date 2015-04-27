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

@interface DestinyViewController ()<BaseViewControllerDelegate,MJLockViewDelegate>
/**划屏选择*/
@property (strong, nonatomic) IBOutlet MJLockView *lockView;

@end

@implementation DestinyViewController
#pragma mark 懒加载


#pragma mark 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.lockView.delegate = self;
}

#pragma mark 自定义函数

#pragma mark 代理
- (void)lockView:(MJLockView *)lockView didFinishPath:(NSString *)path
{
    FZ_LOG(@"%@",path);
}

@end
