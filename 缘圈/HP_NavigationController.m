//
//  HP_NavigationController.m
//  缘圈
//
//  Created by 徐 阳 on 15/4/26.
//  Copyright (c) 2015年 iOS. All rights reserved.
//
#import "FontMacros.h"
#import "DeviceMacros.h"
#import "ColorMarcros.h"
#import "UIImage+Common4IOS.h"
#import "ColorMarcros.h"

#import "HP_NavigationController.h"

@interface HP_NavigationController ()

@end

@implementation HP_NavigationController

/**
 *  设置所有导航栏的主题,这个方法一个类只会调用一次
 */
+ (void)initialize
{
	[self setupNavBarTheme];
	[self setupBarButtonItemTheme];
}

+ (void)setupBarButtonItemTheme
{
	//按钮
	UIBarButtonItem *item = [UIBarButtonItem appearance];

    [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
	
	
	//按钮文字
	NSMutableDictionary *attrsDisable = [NSMutableDictionary dictionary];
	attrsDisable[NSFontAttributeName] = kNavButtonFont;
	attrsDisable[NSForegroundColorAttributeName ] = [UIColor lightGrayColor];
	attrsDisable[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
	[item setTitleTextAttributes:attrsDisable forState:UIControlStateDisabled];
	
	
	//
	NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
	attrs[NSFontAttributeName] = kNavButtonFont;
	attrs[NSForegroundColorAttributeName ] = [UIColor lightGrayColor];
	attrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
	if(IOS7){
		attrs[NSForegroundColorAttributeName ] = kColor(234, 103, 7, 1);
	}
	[item setTitleTextAttributes:attrs forState:UIControlStateNormal];
	[item setTitleTextAttributes:attrs forState:UIControlStateHighlighted];
}

+ (void)setupNavBarTheme
{
	UINavigationBar *navBarAppearance = [UINavigationBar appearance];
	//背景
	
    [navBarAppearance setBackgroundImage:[UIImage getImageFromColor:kNavigationBackgroundColor] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
	
    [navBarAppearance setTranslucent:NO];
    
	//标题
	NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName]  = [UIColor whiteColor];
    attrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
	attrs[NSFontAttributeName] = kNavTitleFont;
	[navBarAppearance setTitleTextAttributes:attrs];
	
	navBarAppearance.tintColor = [UIColor orangeColor];
	
}
- (void)viewDidLoad {
	[super viewDidLoad];
	
	
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if(self.viewControllers.count >0 ){
		viewController.hidesBottomBarWhenPushed = YES;
	}
	[super pushViewController:viewController animated:animated];
}


@end
