//
//  NSData+Common4IOS.h
//  缘圈
//
//  Created by 徐 阳 on 15/4/25.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Common4IOS)
//获得NSData对象的大小（单位：KB）
+(NSInteger) getKBFromData:(NSData *) data;

//获得NSData对象的大小（单位：MB）
+(NSInteger) getMBFromData:(NSData *) data;

//获得NSData对象的大小（单位：GB）
+(NSInteger) getGBFromData:(NSData *) data;

@end
