//
//  DeviceTool.h
//  缘圈
//
//  Created by 徐 阳 on 15/4/26.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#ifndef ___DeviceMacros_h
#define ___DeviceMacros_h

#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6)

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define StateBarHeight 20
#define MainHeight (ScreenHeight - StateBarHeight)
#define MainWidth ScreenWidth
#endif
