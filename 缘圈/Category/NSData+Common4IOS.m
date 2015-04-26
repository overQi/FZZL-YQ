//
//  NSData+Common4IOS.m
//  缘圈
//
//  Created by 徐 阳 on 15/4/25.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "NSData+Common4IOS.h"

@implementation NSData (Common4IOS)
+(NSInteger) getKBFromData:(NSData *) data{
	return data.length/1024;
}

+(NSInteger) getMBFromData:(NSData *) data{
	return data.length/1024/1024;
}

+(NSInteger) getGBFromData:(NSData *) data{
	return data.length/1024/1024/1024;
}

@end
