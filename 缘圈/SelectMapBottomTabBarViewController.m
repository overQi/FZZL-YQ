//
//  SelectMapBottomTabBarViewController.m
//  缘圈
//
//  Created by 徐 阳 on 15/5/1.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "SelectMapBottomTabBarViewController.h"

@interface SelectMapBottomTabBarViewController ()

- (IBAction)confirmBtnClick:(UIButton *)sender;
@end

@implementation SelectMapBottomTabBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
	
}



- (IBAction)confirmBtnClick:(UIButton *)sender {
	if([self.delegate respondsToSelector:@selector(baseViewController:CallbackData:)])
	{
		[self.delegate baseViewController:self CallbackData:@"btnClick"];
	}
}
@end
