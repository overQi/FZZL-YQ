//
//  MyInfoViewController.m
//  缘圈
//
//  Created by FangZhouZhiLian on 15-5-4.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "MyInfoViewController.h"

@interface MyInfoViewController ()
@property (nonatomic,strong) NSMutableArray *detailInfoM;
@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
    
}

- (void)setupUI
{
    
}

- (void)setupData
{
    [self.detailInfoM addObject:@"我的昵称"];
    [self.detailInfoM addObject:@"诚信等级"];
    [self.detailInfoM addObject:@"姓名"];
    [self.detailInfoM addObject:@"性别"];
    [self.detailInfoM addObject:@"手机号"];
    [self.detailInfoM addObject:@"工作"];
    [self.detailInfoM addObject:@"居住"];
    [self.detailInfoM addObject:@"故乡"];
    [self.detailInfoM addObject:@"身份证号"];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.detailInfoM.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, MainWidth, 80.0)];
    customView.backgroundColor = [UIColor whiteColor];
    
    UILabel * headerLabel            = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor      = [UIColor clearColor];
    headerLabel.opaque               = NO;
   
    headerLabel.font                 = [UIFont boldSystemFontOfSize:16];
    
    CGFloat headerLabelX = 10.0;
    if(isNotiPhone6Plus){
        headerLabelX = 15.0;
    }else{
        headerLabelX = 20.0;
    }
    headerLabel.frame                = CGRectMake(headerLabelX, 0.0, MainWidth, 80.0);
    headerLabel.text             = @"我的头像";
    
    [customView addSubview:headerLabel];
    
    
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.image = [UIImage imageNamed:@"testicon.jpg"];
    iconImage.frame = CGRectMake(MainWidth - 70 - 5, 5, 70, 70);
    [iconImage.layer setBorderWidth:1];
    [iconImage.layer setBorderColor:[UIColor blueColor].CGColor];
    iconImage.layer.cornerRadius = iconImage.frame.size.width / 2;
    iconImage.clipsToBounds = YES;
    [customView addSubview:iconImage];
    
    return customView;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, MainWidth, 80.0)];
    customView.backgroundColor = [UIColor whiteColor];
    
    UILabel * footerLabel            = [[UILabel alloc] initWithFrame:CGRectZero];
    footerLabel.backgroundColor      = [UIColor clearColor];
    footerLabel.opaque               = NO;
    
    footerLabel.font                 = [UIFont boldSystemFontOfSize:16];
    
    CGFloat headerLabelX = 10.0;
    if(isNotiPhone6Plus){
        headerLabelX = 15.0;
    }else{
        headerLabelX = 20.0;
    }
    footerLabel.frame                = CGRectMake(headerLabelX, 10, MainWidth, 22.0);

    footerLabel.text                 = @"上传照片";
    [customView addSubview:footerLabel];
    
    return customView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 150.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyInfoCell";
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }

    cell.textLabel.text = self.detailInfoM[indexPath.row];
    cell.detailTextLabel.text = @"测试数据";
    
    return cell;
}

#pragma mark 懒加载
- (NSMutableArray *)detailInfoM
{
    if(_detailInfoM == nil)
    {
        _detailInfoM = [NSMutableArray array];
    }
    return _detailInfoM;
}

@end
