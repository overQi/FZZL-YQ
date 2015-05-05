//
//  oderDetailFrame.h
//  缘圈
//
//  Created by ChainGo on 15/4/24.
//  Copyright (c) 2015年 东亚重工. All rights reserved.
//

#define leftMargin 10
#define topMargin 10

#define UserNameLabelFont [UIFont systemFontOfSize:16]
#define VerifyLabelFont [UIFont systemFontOfSize:15]

#define OrderLabelDefaultFont [UIFont systemFontOfSize:14]

#define screenSize [UIScreen mainScreen].bounds.size

#import <Foundation/Foundation.h>
#import "UserDetail.h"

@interface UserDetailFrame : NSObject

/** Frame模型嵌套数据模型 */
@property (nonatomic, strong) UserDetail *userDetail;


/**用户头像*/
@property (nonatomic, assign) CGRect iconBtnF;

/**认证角标*/
@property (nonatomic, assign) CGRect verifyBtnF;

/**名称Label*/
@property (nonatomic, assign) CGRect nameLF;

/**认证状态Label*/
@property (nonatomic, assign) CGRect verifyLF;

/**年龄*/
@property (nonatomic, assign) CGRect ageLF;

/**好评度*/
@property (nonatomic, assign) CGRect reputationLF;

/**居住地*/
@property (nonatomic, assign) CGRect residenceLF;

/**工作地*/
@property (nonatomic, assign) CGRect workPlaceLF;

/** 容器Frame */
@property (nonatomic, assign) CGRect userHeadCellViewF;

/** cell的行高 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
