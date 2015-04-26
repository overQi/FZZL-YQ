//
//  DestinyViewController.m
//  缘圈
//
//  Created by 徐 阳 on 15/4/26.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "DestinyViewController.h"
#import "UserModel.h"
#import "testViewController.h"
@interface DestinyViewController ()<BaseViewControllerDelegate>

@end

@implementation DestinyViewController
#pragma mark 懒加载


#pragma mark 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor greenColor];
	
	//测试从另一个控制器返回数据
	TestViewController *vc	  = [[TestViewController alloc] init];
	vc.delegate = self;
	[self.navigationController pushViewController:vc animated:YES];

	//自定义Object的保存
    UserModel *user = [[UserModel alloc] init];
    user.userID     = @"10011";
    user.userName   = @"zxcwqe";
    user.password   = @"xveyrtw";
	[self setArchiveObject:user forKey:@"userModel"];
	
	//读取出来
	UserModel *user1 = (UserModel *)[self getArchivedObjectForKey:@"userModel"];
	FZ_LOG(@"%@",user1.userName);	//这里没有写description 偷懒了，意思懂了就好
	
	
//	self setObjectForNSUserDefaults:<#(id)#> forKey:<#(NSString *)#>
//	self getObjectFromNSUserDefaultsForKey:<#(NSString *)#>
//	self setStringForNSUserDefaults:<#(NSString *)#> forKey:<#(NSString *)#>
//  self getStringFromNSUserDefaultsForKey:<#(NSString *)#>
	//除了这些还有很多方法，自己试一下
	
	
}

#pragma mark 自定义函数

#pragma mark 代理
- (void)baseViewController:(HP_BaseViewController *)controller CallbackData:(id)data
{
	FZ_LOG(@":%@", [controller class]);
	
	NSString *str = (NSString *)data;
	
	FZ_LOG(@"%@",str);
}
@end
