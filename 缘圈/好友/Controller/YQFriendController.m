//
//  YQFriendController.m
//  缘圈
//
//  Created by ChainGo on 15/4/28.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "UserHeadCell.h"
#import "UserDetailFrame.h"
#import "YQFriendController.h"

@interface YQFriendController ()

/** 总数据 */
@property (nonatomic, strong) NSMutableArray *userDetailFrames;

@end


@implementation YQFriendController
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupData];
}

- (void)setupData
{
    // 测试数据 若不赋值label会自动隐藏
    UserDetail *detail = [[UserDetail alloc] init];
    
    detail.iconBtnImg = @"camera";
    detail.age = 27;
    detail.isverify = YES;
    detail.verifyImg = @"verifyImg";
    detail.name = @"李武";
    detail.verifyStr = @"已认证";
    detail.reputaionStr = @"好评100%";
    detail.residenceStr = @"西三旗龙旗广场D座407号";
    detail.workPlaceStr = @"工作地: 西三旗龙旗广场D座407号";
    
    UserDetailFrame *userDetailFrame = [[UserDetailFrame alloc] init];
    userDetailFrame.userDetail = detail;
    
    [self.userDetailFrames addObject:userDetailFrame];
}


#pragma mark - Table view data source & delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UserDetailFrame *userDetailFrame = self.userDetailFrames[0];

    if (indexPath.row == 0) {//TODO: 第一个cell去除间距
    
    }
    return userDetailFrame.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0;
}


// cellHeaderView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.view.width,30)];
    view.backgroundColor = [UIColor grayColor];
    UILabel *titleL = [[UILabel alloc] init];
    
    NSString *title;
    if (section == 0) {
        title = @"我的好友";
    }else if (section == 1){
        title = @"我的群组";
    }
    
    titleL.attributedText = [[NSAttributedString alloc] initWithString:title attributes:@{
                                                                                          
                                                                                          NSFontAttributeName : kFriendHeadTitleFont,
                                                                                          NSForegroundColorAttributeName : kFriendHeadTitleColor,
                                                                                          }];

    [titleL sizeToFit];
    titleL.centerX = CGRectGetMidX(view.bounds);
    titleL.y = CGRectGetMidY(view.bounds);
    
//    NSLog(@"%f", CGRectGetMidX(self.view.frame));
//    NSLog(@"%f", CGRectGetMidY(view.bounds));

    [view addSubview:titleL];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.view.width,20)];
    view.backgroundColor = [UIColor clearColor];

    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return 3;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserHeadCell *cell = [UserHeadCell cellWithTableView:tableView];
#warning 仍然只有一条数据,先用仅有的一条测试
    UserDetailFrame *userDetailFrame = self.userDetailFrames[0];
    
    cell.userDetailFrame = userDetailFrame;
    
    return cell;
}


#pragma mark - 懒加载
- (NSMutableArray *)userDetailFrames
{
    if (!_userDetailFrames)
    {
        _userDetailFrames = [NSMutableArray array];
    }
    return _userDetailFrames;
}
@end

