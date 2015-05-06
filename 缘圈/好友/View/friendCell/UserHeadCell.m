//
//  orderCell.m
//  缘圈
//
//  Created by ChainGo on 15/4/24.
//  Copyright (c) 2015年 东亚重工. All rights reserved.
//

#import "UserHeadCell.h"
#import "UserHeadCellView.h"
#import "UserDetailFrame.h"

#define kFirendCellBG [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
@interface UserHeadCell ()

/** cell子控件容器 */
@property (nonatomic, strong) UserHeadCellView *subCellview;

@end

@implementation UserHeadCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"YQFriendCell";
    UserHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 容器视图
        UserHeadCellView *subCellview = [[UserHeadCellView alloc] init];
        [self.contentView addSubview:subCellview];
        self.subCellview = subCellview;
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(celldidPan:)]; //TODO: cell滑动呼出二级菜单
//        [self addGestureRecognizer:pan];
        
    }
    return self;
}


#pragma mark - 手势代理
- (void)celldidPan:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    NSLog(@"手势坐标 == %f %f", point.x, point.y);
}

// 传递数据到子view
-(void)setUserDetailFrame:(UserDetailFrame *)userDetailFrame
{
    _userDetailFrame = userDetailFrame;
    
    self.subCellview.userDetailFrame = userDetailFrame;
}

@end





