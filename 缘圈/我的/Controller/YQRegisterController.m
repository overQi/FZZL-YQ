//
//  YQRegisterController.m
//  缘圈
//
//  Created by ChainGo on 15/5/4.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "YQRegisterController.h"

@interface YQRegisterController ()
@property (weak, nonatomic) IBOutlet UITextField *numberTextF;
@property (weak, nonatomic) IBOutlet UITextField *verifTextF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextF;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (nonatomic, strong) UIButton *verfiBtn;
@end

@implementation YQRegisterController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    self.title = @"注册";
}

- (void)setUI
{
    self.registerBtn.layer.cornerRadius = 6;
    self.registerBtn.clipsToBounds = YES;
    
    // 占位文字
    NSDictionary *placeAtts = [NSDictionary dictionary];
    placeAtts = @{
                  NSFontAttributeName : [UIFont systemFontOfSize:16],
                  };
    
    NSAttributedString *placeStr = [[NSAttributedString alloc] initWithString:@"手机号码" attributes:placeAtts];
    NSAttributedString *pwdStr = [[NSAttributedString alloc] initWithString:@"密码" attributes:placeAtts];
    NSAttributedString *verifStr = [[NSAttributedString alloc] initWithString:@"验证码" attributes:placeAtts];
    
    [self.pwdTextF setAttributedPlaceholder:pwdStr];
    [self.verifTextF setAttributedPlaceholder:verifStr];
    [self.numberTextF setAttributedPlaceholder:placeStr];
    
    
    // 光标初始位置
    UILabel *paddingView1 = [[UILabel alloc] init];
    paddingView1.width = 15;
    paddingView1.backgroundColor = [UIColor clearColor];
    UILabel *paddingView2 = [[UILabel alloc] init];
    paddingView2.width = 15;
    paddingView2.backgroundColor = [UIColor clearColor];
    UILabel *paddingView3 = [[UILabel alloc] init];
    paddingView3.width = 15;
    paddingView3.backgroundColor = [UIColor clearColor];
    
    self.numberTextF.leftView = paddingView1;
    self.numberTextF.leftViewMode = UITextFieldViewModeAlways;
    self.pwdTextF.leftView = paddingView2;
    self.pwdTextF.leftViewMode = UITextFieldViewModeAlways;
    self.verifTextF.leftView = paddingView3;
    self.verifTextF.leftViewMode = UITextFieldViewModeAlways;
    
    // 验证码按钮
    UIButton *verfiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    NSDictionary *titleAtt = [NSDictionary dictionary];
    
    titleAtt = @{
                  NSFontAttributeName : [UIFont systemFontOfSize:14],
                  NSForegroundColorAttributeName : [UIColor whiteColor],
                  };
    
    NSAttributedString *btnTitle = [[NSAttributedString alloc] initWithString:@"获取验证码" attributes:titleAtt];
    NSAttributedString *disAtt = [[NSAttributedString alloc] initWithString:@"已发送验证码" attributes:titleAtt];

    [verfiBtn setAttributedTitle:btnTitle forState:UIControlStateNormal];
    [verfiBtn setAttributedTitle:disAtt forState:UIControlStateDisabled];
    
    [verfiBtn setBackgroundColor:[UIColor colorWithRed:0.98 green:0.69 blue:0.36 alpha:1]];
    [verfiBtn addTarget:self action:@selector(verfiClick:) forControlEvents:UIControlEventTouchDown];
 
    CGFloat btnW = 120;
    CGFloat btnH = self.numberTextF.height;
    CGFloat btnX = ScreenWidth - btnW;
    CGFloat btnY = CGRectGetMaxY(self.verifTextF.frame) - btnH;
    verfiBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    self.verfiBtn = verfiBtn;
    [self.view addSubview:verfiBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 按钮Action
- (IBAction)registerClick:(UIButton *)sender {
    
    NSLog(@"待完善");
}

- (void)verfiClick:(UIButton *)btn
{
    [self.verfiBtn setBackgroundColor:[UIColor lightGrayColor]];
    self.verfiBtn.enabled = NO;
}

@end
