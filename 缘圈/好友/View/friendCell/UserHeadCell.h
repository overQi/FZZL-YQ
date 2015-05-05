//
//  orderCell.h
//  缘圈
//
//  Created by ChainGo on 15/4/24.
//  Copyright (c) 2015年 东亚重工. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserDetailFrame;
@interface UserHeadCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** oderDetailFrame模型 */
@property (nonatomic, strong) UserDetailFrame *userDetailFrame;

@end
