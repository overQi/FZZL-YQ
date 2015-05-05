//
//  oderDetailFrame.m
//  缘圈
//
//  Created by ChainGo on 15/4/24.
//  Copyright (c) 2015年 东亚重工. All rights reserved.
//

#import "UserDetailFrame.h"

@implementation UserDetailFrame

-(void)setUserDetail:(UserDetail *)userDetail
{
    _userDetail = userDetail;

    CGFloat iconBtnX = leftMargin;
    CGFloat iconBtnY = topMargin;
    CGFloat iconBtnW = 60;
    CGFloat iconBtnH = iconBtnW;
    
    _iconBtnF = CGRectMake(iconBtnX, iconBtnY, iconBtnW, iconBtnH);
    

    CGFloat verifyBtnW = 10;
    CGFloat verifyBtnH = verifyBtnW;
    CGFloat verifyBtnX = iconBtnW - verifyBtnW * 0.5;
    CGFloat verifyBtnY = iconBtnY - verifyBtnH * 0.5;
    
    _verifyBtnF = CGRectMake(verifyBtnX, verifyBtnY, verifyBtnW, verifyBtnH);
    
    
    CGFloat nameLX = CGRectGetMaxX(_iconBtnF) + 3 * leftMargin;
    CGFloat nameLY = iconBtnY;
    
    CGSize nameLConstrainSize = CGSizeMake(screenSize.width - nameLX - leftMargin, MAXFLOAT);
    CGSize nameLSize = [userDetail.name sizeWithFont:UserNameLabelFont constrainedToSize:nameLConstrainSize];
    
    if (userDetail.name.length == 0){
        nameLSize = CGSizeZero;
    }
    _nameLF = (CGRect){{nameLX, nameLY}, nameLSize};
    
    
    CGFloat verifyLX = CGRectGetMaxX(_nameLF) + 2 * leftMargin;
    CGFloat verifyLY = iconBtnY;
    
    CGSize verifyLConstrainSize = CGSizeMake(screenSize.width - verifyLX - leftMargin, MAXFLOAT);
    CGSize verifyLSize = [userDetail.verifyStr sizeWithFont:VerifyLabelFont constrainedToSize:verifyLConstrainSize];
    
    _verifyLF = (CGRect){{verifyLX, verifyLY}, verifyLSize};
    
    
    CGFloat ageLX = nameLX;// remember: 可能需要居中
    CGFloat ageLY = CGRectGetMaxY(_nameLF) + 2 * topMargin;

    CGSize ageLConstrainSize = CGSizeMake(screenSize.width - ageLX - leftMargin, MAXFLOAT);

    NSString *ageStr = [NSString  stringWithFormat:@"%zd岁",userDetail.age];
    CGSize ageLSize = [ageStr sizeWithFont:OrderLabelDefaultFont constrainedToSize:ageLConstrainSize];
    
    _ageLF = (CGRect){{ageLX, ageLY}, ageLSize};
    
    
    CGFloat reputationLX = verifyLX;
    CGFloat reputationLY = ageLY;
    
    CGSize reputationLConstrainSize = CGSizeMake(screenSize.width - reputationLX - leftMargin, MAXFLOAT);
    CGSize reputationLSize = [userDetail.reputaionStr sizeWithFont:OrderLabelDefaultFont constrainedToSize:reputationLConstrainSize];

    _reputationLF = (CGRect){{reputationLX, reputationLY}, reputationLSize};
    
    
    CGFloat residenceLX = nameLX;
    CGFloat residenceLY = CGRectGetMaxY(_ageLF) + topMargin;
    
    CGSize residenceLConstrainSize = CGSizeMake(screenSize.width - residenceLX - leftMargin, MAXFLOAT);
    CGSize residenceLSize = [userDetail.residenceStr sizeWithFont:OrderLabelDefaultFont constrainedToSize:reputationLConstrainSize];
    
    _residenceLF = (CGRect){{residenceLX, residenceLY}, residenceLSize};
    
    
    CGFloat workPlaceLX = nameLX;
    CGFloat workPlaceLY = CGRectGetMaxY(_residenceLF) + topMargin;
    
    CGSize workPlaceLConstrainSize = CGSizeMake(screenSize.width - workPlaceLX - leftMargin, MAXFLOAT);
    CGSize workPlaceLSize = [userDetail.workPlaceStr sizeWithFont:OrderLabelDefaultFont constrainedToSize:workPlaceLConstrainSize];
    
    _workPlaceLF = (CGRect){{workPlaceLX, workPlaceLY}, workPlaceLSize};
    

    CGFloat userHeadCellViewX = 0;
    CGFloat userHeadCellViewY = 20;
    CGFloat userHeadCellViewW = screenSize.width;
    CGFloat userHeadCellViewH = CGRectGetMaxY(_workPlaceLF) + 20;
    _userHeadCellViewF = CGRectMake(userHeadCellViewX, userHeadCellViewY, userHeadCellViewW, userHeadCellViewH);
    
    _cellHeight = CGRectGetMaxY(_userHeadCellViewF);
}
@end
