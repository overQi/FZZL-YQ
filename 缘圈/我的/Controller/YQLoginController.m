//
//  YQLoginController.m
//  缘圈
//
//  Created by ChainGo on 15/5/4.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "YQRegisterController.h"
#import "YQLoginController.h"

@interface YQLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *numberTextF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextF;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation YQLoginController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self setUI];
}

- (void)setNav
{
    // NavigationBar
    self.title = @"登录";
    
    NSDictionary *navAtts = [NSDictionary dictionary];
    navAtts = @{
             NSForegroundColorAttributeName : [UIColor whiteColor],
             };
    [self.navigationController.navigationBar setTitleTextAttributes:navAtts];
    
    
    // rightItem
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick:)];

    NSDictionary *atts = [NSDictionary dictionary];
    atts = @{
             NSForegroundColorAttributeName : [UIColor whiteColor],
             NSFontAttributeName : [UIFont systemFontOfSize:14],
             };
    [rightItem setTitleTextAttributes:atts forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.36 green:0.61 blue:0.99 alpha:1]; //TODO: 背景主题修改
}

- (void)setUI
{
    self.loginBtn.layer.cornerRadius = 6;
    self.loginBtn.clipsToBounds = YES;
    
    // 占位文字
    NSDictionary *placeAtts = [NSDictionary dictionary];
    placeAtts = @{
                NSFontAttributeName : [UIFont systemFontOfSize:16],
                };
    
    NSAttributedString *placeStr = [[NSAttributedString alloc] initWithString:@"手机号" attributes:placeAtts];
    NSAttributedString *pwdStr = [[NSAttributedString alloc] initWithString:@"密码" attributes:placeAtts];
    
    self.pwdTextF.textAlignment = NSTextAlignmentLeft;
    [self.pwdTextF setAttributedPlaceholder:pwdStr];
    [self.numberTextF setAttributedPlaceholder:placeStr];
    
    
    // 光标占位位置
    UILabel *paddingView1 = [[UILabel alloc] init];
    paddingView1.width = 15;
    paddingView1.backgroundColor = [UIColor clearColor];
    UILabel *paddingView2 = [[UILabel alloc] init];
    paddingView2.width = 15;
    paddingView2.backgroundColor = [UIColor clearColor];
    
    self.numberTextF.leftView = paddingView1;
    self.numberTextF.leftViewMode = UITextFieldViewModeAlways;
    self.pwdTextF.leftView = paddingView2;
    self.pwdTextF.leftViewMode = UITextFieldViewModeAlways;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    NSLog(@"didReceiveMemoryWarning");
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (void)rightClick:(UIBarButtonItem *)item
{
    YQRegisterController *registerVc = [[YQRegisterController alloc] init];
    [self.navigationController pushViewController:registerVc animated:YES];
}

- (IBAction)loginClick:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
