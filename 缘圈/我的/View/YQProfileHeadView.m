//
//  YQProfileHeadView.m
//  缘圈
//
//  Created by ChainGo on 15/4/29.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "HP_NavigationController.h"
#import "YQLoginController.h"
#import "YQProfileHeadView.h"

@interface YQProfileHeadView ()


@end

@implementation YQProfileHeadView

- (IBAction)logOutClick:(UIButton *)sender {
    

    // TODO: 从登录界面modal出其他界面
    HP_NavigationController *nav = [[HP_NavigationController alloc] initWithRootViewController:[[YQLoginController alloc] init]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}

@end
