//
//  ColorTool.h
//  缘圈
//
//  Created by FangZhouZhiLian on 15-4-24.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#ifndef ___ColorTool_h
#define ___ColorTool_h

//颜色设置
#define kColor(r, g, b, a)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]
#define kMBScreenNameColor  kColor(240, 100, 20, 1)                            // 会员用户昵称颜色
#define kScreenNameColor    kColor(0, 0, 0, 1)                                 // 普通用户昵称颜色
#define kTimeColor          kColor(200, 100, 30, 1)                            // 微博发表时间显示颜色
#define kSourceColor        [UIColor lightGrayColor]                            // 来源显示颜色
#define kReTextColor        [UIColor colorWithWhite:0.355 alpha:1.000]

#endif
