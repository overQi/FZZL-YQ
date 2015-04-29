//
//  MJLockView.h
//  03-手势解锁
//
//  Created by apple on 14-4-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#define kButtonNumber				4	//按钮数量
#define kTotalColumns				2	//列数
#define kMaxSelectedBtnNumber		2	//最大被选中按钮数
#define kLineColor [UIColor colorWithRed:32/255.0 green:210/255.0 blue:254/255.0 alpha:0.5]

#import <UIKit/UIKit.h>
@class MJLockView;

@protocol MJLockViewDelegate <NSObject>

@optional
- (void)lockView:(MJLockView *)lockView didFinishPath:(NSString *)path;

@end

@interface MJLockView : UIView


@property (nonatomic, weak) IBOutlet id<MJLockViewDelegate> delegate;
@end
