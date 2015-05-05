//
//  UserData.h
//  缘圈
//
//  Created by ChainGo on 15/4/27.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h> 

@interface UserView : UIView

/** 头像 */
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
/** 用户名 */
@property (weak, nonatomic) IBOutlet UILabel *userNameL;
/** 消费记录 */
@property (weak, nonatomic) IBOutlet UILabel *purchaseCountL;
/** 评价 */
@property (weak, nonatomic) IBOutlet UILabel *commenL;
/** 评价星级图片 */
@property (weak, nonatomic) IBOutlet UIImageView *starImg;
/** 发送短信 */
@property (weak, nonatomic) IBOutlet UIButton *callMessageBtn;
/** 拨打电话 */
@property (weak, nonatomic) IBOutlet UIButton *callPhoneBtn;

@end









