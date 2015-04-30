//
//  MJCircleView.m
//  03-手势解锁
//
//  Created by apple on 14-4-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJCircleView.h"

@implementation MJCircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

/**
 初始化
 */
- (void)setup
{
    
    // 设置按钮不可用
    self.userInteractionEnabled = NO;
	if([[NSDate isDayOrNight] isEqualToString:@"白天"])
	{
		[self setTitleColor:kYuanQuanBtnTextDayColor forState:UIControlStateNormal];
	}else{
		[self setTitleColor:kYuanQuanBtnTextNightColor forState:UIControlStateNormal];
	}
	
    self.titleLabel.font          = kYuanQuanBtnFont;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height - 38, contentRect.size.width, 20);
}

@end
