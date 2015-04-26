//
//  NSString+Common4IOS.h
//  缘圈
//
//  Created by FangZhouZhiLian on 15-4-24.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common4IOS)

/**GBK转UTF-8*/
+(NSString *) getStringUTF8ToGBK:(NSString *) string;

//UTF-8转GBK
+(NSString *) getStringGBKToUTF8:(NSString *) string;

//NSString类型转NSDate类型
+(NSData *) getDataFromString:(NSString *) string encoding:(NSStringEncoding)encoding;

//加前缀
+(NSString *) addPrefix:(NSString *) prefix withString:(NSString *) str;

//加后缀
+(NSString *) addSuffix:(NSString *) suffix withString:(NSString *) str;

//根据字符串、字体获得字体所占空间大小CGSize
+(CGSize)getTextSizeByString:(NSString *) string byFont:(UIFont *) font;

//根据字符串、字体获得字体所占空间大小CGSize，限制再size大小范围内
+(CGSize)getTextSizeByString:(NSString *) string byFont:(UIFont *) font bySize:(CGSize) size;

//根据字符串将原字符串截取为数组
+(NSArray *)splitString:(NSString*) string withStr:(NSString*)str;

//根据字符位置截取字符串
+(NSString *)getSubStringWithString:(NSString *) string from:(NSInteger)start to:(NSInteger)end;

@end
