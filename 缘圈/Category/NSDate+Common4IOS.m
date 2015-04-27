//
//  NSDate+Common4IOS.m
//  缘圈
//
//  Created by 徐 阳 on 15/4/25.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "NSDate+Common4IOS.h"

@implementation NSDate (Common4IOS)

+(BOOL)compareDate:(NSDate *)date1 isEarlierDate:(NSDate *) date2{
	BOOL isEarlier = NO;
	
	if ([date1 isEqualToDate:[date1 earlierDate:date2]]) {
		isEarlier = YES;
	};
	
	return isEarlier;
}

+(BOOL)compareTime:(NSTimeInterval)time1 isEarlierTime:(NSTimeInterval) time2{
	BOOL isEarlier = NO;
	NSDate *date1 = [self getDateFromTimeInterval:time1];
	NSDate *date2 = [self getDateFromTimeInterval:time2];
	
	if ([date1 isEqualToDate:[date1 earlierDate:date2]]) {
		isEarlier = YES;
	};
	
	return isEarlier;
}

+(BOOL)isLongerThen24Hours:(NSTimeInterval)time {
	
	BOOL isLonger = NO;
	if(time>24*60*60){
		isLonger = YES;
	}
	return isLonger;
}


+(NSDate *) getDateFromTimeInterval:(NSTimeInterval) interval{
	
	return [NSDate dateWithTimeIntervalSince1970:interval];
}

+(NSTimeInterval) getTimeIntervalFromDate:(NSDate *)date{
	
	return [date timeIntervalSince1970];
	
}

@end
