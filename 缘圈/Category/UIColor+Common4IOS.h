//
//  UIColor+Common4IOS.h
//  缘圈
//
//  Created by FangZhouZhiLian on 15-4-24.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Common4IOS)

//根据#AARRGGBB,#RRGGBB,#ARGB,#RGB获得UIColor
+ (UIColor *) colorWithHexString: (NSString *) hexString;

@end
