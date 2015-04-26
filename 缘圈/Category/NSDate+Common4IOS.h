//
//  NSDate+Common4IOS.h
//  缘圈
//
//  Created by 徐 阳 on 15/4/25.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Common4IOS)
//比较date1是否在date2之前
+(BOOL)compareDate:(NSDate *)date1 isEarlierDate:(NSDate *) date2;

//比较time1是否在time2之前
+(BOOL)compareTime:(NSTimeInterval)time1 isEarlierTime:(NSTimeInterval) time2;

//比较time是否大与24小时
+(BOOL)isLongerThen24Hours:(NSTimeInterval)time ;

//NSTimeInterval 类型转换为 NSDate类型
+(NSDate *) getDateFromTimeInterval:(NSTimeInterval) interval;

//NSDate 类型转换为 NSTimeInterval类型
+(NSTimeInterval) getTimeIntervalFromDate:(NSDate *)date;

@end
