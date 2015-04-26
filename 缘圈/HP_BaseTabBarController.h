//
//  HP_BaseTabBarController.h
//  youyouapp
//
//  Created by Yi Xu on 12-11-30.
//  Copyright (c) 2012年 CuiYiLong. All rights reserved.
//

//状态栏高度
#define StateBarHeight 20

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define MainHeight (ScreenHeight - StateBarHeight)
#define MainWidth ScreenWidth

#import <UIKit/UIKit.h>

@interface HP_BaseTabBarController : UITabBarController


/**传送数据Dictionary*/
@property (strong, nonatomic) NSMutableDictionary *dataArrayM;


/**获得屏幕Rect*/
-(CGRect) getScreenRect;

/**获得屏幕Size*/
-(CGSize) getScreenSize;

/**获得屏幕缩放比例*/
-(CGFloat) getScreenScale;

/**获得屏幕宽度像素*/
-(CGFloat) getScreenWidthPixels;

/**获得屏幕高度像素*/
-(CGFloat) getScreenHeightPixels;

/**简单的系统提示框*/
-(void)showAlertViewWithTitle:(NSString *)title alertMessage:(NSString *)msg cancelButtonTitle:(NSString *) cancelTitle otherButtonTitles:(NSString *)otherButtonTitles;

/**隐藏TabBar*/
-(void)hideTabBar;

/**获得NSUserDefaults对象*/
-(NSUserDefaults *)getNSUserDefaults;

/**向NSUserDefaults对象存入NSMutableDictionary*/
-(void) setDictionaryForNSUserDefaults:(NSMutableDictionary *) dictionary forKey:(NSString *)key;

/**向NSUserDefaults对象存入id*/
-(void) setObjectForNSUserDefaults:(id) object forKey:(NSString *)key;

/**向NSUserDefaults对象存入NSString*/
-(void) setStringForNSUserDefaults:(NSString *) string forKey:(NSString *)key;

/**从NSUserDefaults获得id对象*/
-(id) getObjectFromNSUserDefaultsForKey:(NSString *)key;

/**从NSUserDefaults获得NSString对象*/
-(NSString *) getStringFromNSUserDefaultsForKey:(NSString *)key;

/**从NSUserDefaults获得NSDictionary对象*/
-(NSDictionary *) getDictionaryFromNSUserDefaultsForKey:(NSString *)key;

/**向NSKeyedUnarchiver存入对象*/
- (void)setArchiveObject:(id)object forKey:(NSString *)key;

/**从NSKeyedUnarchiver获取对象*/
- (id)getArchivedObjectForKey:(NSString *)key;

@end
