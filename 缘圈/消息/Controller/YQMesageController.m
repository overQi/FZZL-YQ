//
//  YQMesageController.m
//  缘圈
//
//  Created by ChainGo on 15/4/28.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "YQMesageController.h"
#import "YQProfileController.h"

#import "TempController.h"

@interface YQMesageController () <UIScrollViewDelegate>

/** 告知按钮 */
@property (nonatomic, strong) UIButton *sendBtn;

/** 总容器 */
@property (nonatomic, strong) UIScrollView *scrowView;

@end

@implementation YQMesageController
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setUI];
}

- (void)setUI
{
    [self setNav];
    
    [self setView];
}

- (void)setNav
{
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"订单跟踪" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
    
    NSDictionary *attrs = @{NSForegroundColorAttributeName : [UIColor blueColor]};
    [rightBtn setTitleTextAttributes:attrs forState:UIControlStateNormal];

    self.navigationItem.rightBarButtonItem = rightBtn;
}
- (void)setView
{
    // 总容器
    UIScrollView *scrowView = [[UIScrollView alloc] init];
    scrowView.size = [self getScreenSize];
    scrowView.contentSize = self.view.bounds.size;
    scrowView.scrollEnabled = YES;
    scrowView.showsVerticalScrollIndicator = NO;
    scrowView.backgroundColor = kMessageScrollViewBG;
    scrowView.delegate = self;
    self.scrowView = scrowView;
    [self.view addSubview:scrowView];
    
    // 1.用户资料
    UIView *userV = [[NSBundle mainBundle] loadNibNamed:@"UserView" owner:nil options:0].firstObject;
    userV.frame = CGRectMake(kMessageUserVLeftMargin, kMessageUserVTopMargin, self.view.width - 2 * kMessageUserVTopMargin, 100);
    [scrowView addSubview:userV];
    
    // 2.订单编号
    UIView *orderNumV = [[UIView alloc] init];
    orderNumV.x = userV.x;
    orderNumV.y = CGRectGetMaxY(userV.frame) + kMessageUserVTopMargin;
    orderNumV.width = userV.width;
    orderNumV.height = 100;
    orderNumV.backgroundColor = [UIColor redColor];
    
    [scrowView addSubview:orderNumV];
    
    // 3. 按钮
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendBtn = sendBtn;
    
    sendBtn.frame = CGRectMake(0, self.view.height - 100, [UIScreen mainScreen].bounds.size.width, 60);
    [sendBtn setTitle:@"告知" forState:UIControlStateNormal];
    [sendBtn setBackgroundColor: [UIColor colorWithRed:0.37 green:0.75 blue:0.38 alpha:1]];
    [sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [scrowView.superview addSubview:sendBtn];
}


#pragma mark - <按钮点击>
- (void)sendBtnClick
{
    NSLog(@"%s", __func__);
}

- (void)rightBtnClick
{
    NSLog(@"%s", __func__);
 
//    TempController *tempVc = [[TempController alloc] init];
//    [self.navigationController pushViewController:tempVc animated:YES];
    
}


#pragma mark - <UIScrollViewDelegate>
@end