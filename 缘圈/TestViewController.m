//
//  testViewController.m
//  缘圈
//
//  Created by 徐 阳 on 15/4/26.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
@property (nonatomic, weak, readwrite) UIButton *button;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.view.backgroundColor = [UIColor blueColor];
	
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
	[btn addTarget:self action:@selector(callBackData) forControlEvents:UIControlEventTouchUpInside];
	btn.center = self.view.center;
	[self.view addSubview:btn];
	self.button = btn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)callBackData
{
	if([self.delegate respondsToSelector:@selector(baseViewController:CallbackData:)])
	{
		[self.delegate baseViewController:self CallbackData:@"从testViewController传递回去的"];
	}
	
	[self.navigationController popViewControllerAnimated:YES];
}



@end
