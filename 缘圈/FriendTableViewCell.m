//
//  FriendTableViewCell.m
//  缘圈
//
//  Created by FangZhouZhiLian on 15-4-27.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "FriendTableViewCell.h"

@interface FriendTableViewCell()
/**用户头像*/
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;

/**认证角标*/
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;

/**名称Label*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/**认证状态Label*/
@property (weak, nonatomic) IBOutlet UILabel *verifyLabel;

/**年龄*/
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

/**好评度*/
@property (weak, nonatomic) IBOutlet UILabel *reputationLabel;

/**居住地*/
@property (weak, nonatomic) IBOutlet UILabel *residenceLabel;

/**工作地*/
@property (weak, nonatomic) IBOutlet UILabel *workPlaceLabel;

@end


@implementation FriendTableViewCell
#pragma mark 初始化
- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"FriendTableViewCell";
    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FriendTableViewCell" owner:self options:nil]lastObject];

    }
    
    return cell;
}

#pragma mark 数据
- (void)setFriendModel:(FriendModel *)friendModel
{
    _friendModel = friendModel;
    
    //根据具体数据 进行调整
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
@end
