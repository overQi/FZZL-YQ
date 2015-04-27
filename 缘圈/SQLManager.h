//
//  SQLManager.h
//  缘圈
//
//  Created by 徐 阳 on 15/4/26.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface SQLManager : NSObject

/**
 *  缓存个用户
 *
 *  @param 用户数据模型
 */
+ (void)addUser:(UserModel *)user;

/**
 *  缓存N个用户
 *
 *  @param userArray 需要缓存的数据
 */
+ (void)addUsers:(NSArray *)userArray;

/**
 *  获取所有的用户数据
 *
 *  @return 用户模型数组
 */
+ (NSArray *)queryUsers;

/**
 *  条件查询用户数据
 *
 *  @param constraint 查询条件(where id=10213)
 *
 *  @return 用户模型数组
 */
+ (NSArray *)queryUsersByConstraint:(NSString *)constraint;
@end
