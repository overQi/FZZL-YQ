//
//  oderDetail.h
//  缘圈
//
//  Created by ChainGo on 15/4/24.
//  Copyright (c) 2015年 东亚重工. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDetail : NSObject
/**
 *  用户资料数据
 */

/**年龄*/
@property (nonatomic, assign) NSInteger age;

/**用户头像*/
@property (nonatomic, copy) NSString *iconBtnImg;

/** 认证图标 */
@property (nonatomic, copy) NSString *verifyImg;

/**是否认证*/
@property (nonatomic, assign) BOOL isverify;

/**名称*/
@property (nonatomic, copy) NSString *name;

/**认证状态*/
@property (nonatomic, copy) NSString *verifyStr;

/**好评度*/
@property (nonatomic, copy) NSString *reputaionStr;

/**居住地*/
@property (nonatomic, copy) NSString *residenceStr;

/**工作地*/
@property (nonatomic, copy) NSString *workPlaceStr;

@end






