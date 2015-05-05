//
//  orderCellView.m
//  缘圈
//
//  Created by ChainGo on 15/4/24.
//  Copyright (c) 2015年 东亚重工. All rights reserved.
//

#import "UserHeadCellView.h"
#import "UserDetailFrame.h"

#define kOrderCellViewBG [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];

@interface UserHeadCellView ()

/**用户头像*/
@property (nonatomic, strong) UIButton *iconBtn;

/**认证角标*/
@property (nonatomic, strong) UIButton *verifyBtn;

/**名称Label*/
@property (strong, nonatomic)  UILabel *nameLabel;

/**认证状态Label*/
@property (strong, nonatomic)  UILabel *verifyLabel;

/**年龄*/
@property (strong, nonatomic)  UILabel *ageLabel;

/**好评度*/
@property (strong, nonatomic)  UILabel *reputationLabel;

/**居住地*/
@property (strong, nonatomic)  UILabel *residenceLabel;

/**工作地*/
@property (strong, nonatomic)  UILabel *workPlaceLabel;

@end

@implementation UserHeadCellView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        
        self.backgroundColor = kOrderCellViewBG;
    }
    return self;
}

// 添加子控件
- (void)setup
{
    UIButton *iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:iconBtn];
    self.iconBtn = iconBtn;
    
    UIButton *verifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:verifyBtn];
    self.verifyBtn = verifyBtn;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = UserNameLabelFont;
    self.nameLabel = nameLabel;
    [self addSubview:nameLabel];
    
    UILabel *verifyLabel = [[UILabel alloc] init];
    verifyLabel.font = VerifyLabelFont;
    self.verifyLabel = verifyLabel;
    [self addSubview:verifyLabel];
    
    UILabel *ageLabel = [[UILabel alloc] init];
    ageLabel.font = OrderLabelDefaultFont;
    self.ageLabel = ageLabel;
    [self addSubview:ageLabel];
    
    UILabel *reputationLabel = [[UILabel alloc] init];
    reputationLabel.font = OrderLabelDefaultFont;
    self.reputationLabel = reputationLabel;
    [self addSubview:reputationLabel];
    
    UILabel *residenceLabel = [[UILabel alloc] init];
    residenceLabel.font = OrderLabelDefaultFont;
    residenceLabel.numberOfLines = 0;
    self.residenceLabel = residenceLabel;
    [self addSubview:residenceLabel];
    
    UILabel *workPlaceLabel = [[UILabel alloc] init];
    workPlaceLabel.font = OrderLabelDefaultFont;
    workPlaceLabel.numberOfLines = 0;
    self.workPlaceLabel = workPlaceLabel;
    [self addSubview:workPlaceLabel];
}

// 从传递过来的模型中设置子控件数据及Frame
-(void)setUserDetailFrame:(UserDetailFrame *)userDetailFrame
{
    _userDetailFrame = userDetailFrame;
    
    self.frame = userDetailFrame.userHeadCellViewF;
    
    [self setUIData];
    [self setUIFrame];
}

- (void)setUIData
{
    UserDetail *userDetail = self.userDetailFrame.userDetail;
    
    [self.iconBtn setImage:[UIImage imageNamed:userDetail.iconBtnImg] forState:UIControlStateNormal];
    
    // remember: verifyBtn可只根据是否认证直接设置固定的image
    [self.verifyBtn setImage:[UIImage imageNamed:userDetail.verifyImg] forState:UIControlStateNormal];
    
    self.nameLabel.text = userDetail.name;
    
    self.verifyLabel.text = userDetail.verifyStr;
    
    self.ageLabel.text = [NSString  stringWithFormat:@"%zd岁",userDetail.age];
    
    self.reputationLabel.text = userDetail.reputaionStr;

    self.residenceLabel.text = userDetail.residenceStr;
    
    self.workPlaceLabel.text = userDetail.workPlaceStr;

}

- (void)setUIFrame
{
    self.iconBtn.frame = self.userDetailFrame.iconBtnF;
    
    self.verifyBtn.frame = self.userDetailFrame.verifyBtnF;
    
    self.nameLabel.frame = self.userDetailFrame.nameLF;
    
    self.verifyLabel.frame = self.userDetailFrame.verifyLF;
    
    self.ageLabel.frame = self.userDetailFrame.ageLF;
    
    self.reputationLabel.frame = self.userDetailFrame.reputationLF;
    
    self.residenceLabel.frame = self.userDetailFrame.residenceLF;
    
    self.workPlaceLabel.frame = self.userDetailFrame.workPlaceLF;
}
@end







