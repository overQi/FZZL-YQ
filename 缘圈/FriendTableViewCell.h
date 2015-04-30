//
//  FriendTableViewCell.h
//  缘圈
//
//  Created by FangZhouZhiLian on 15-4-27.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FriendModel;
@interface FriendTableViewCell : UITableViewCell
@property (nonatomic, strong, readwrite) FriendModel *friendModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
