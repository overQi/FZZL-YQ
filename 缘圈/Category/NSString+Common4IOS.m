//
//  NSString+Common4IOS.m
//  缘圈
//
//  Created by FangZhouZhiLian on 15-4-24.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "NSString+Common4IOS.h"

@implementation NSString (Common4IOS)

+(NSString *) getStringUTF8ToGBK:(NSString *) string{
    return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+(NSString *) getStringGBKToUTF8:(NSString *) string{
    return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+(NSData *) getDataFromString:(NSString *) string encoding:(NSStringEncoding)encoding{
    //NSUTF32BigEndianStringEncoding
    return [string dataUsingEncoding:encoding];
}

+(NSString *) addPrefix:(NSString *) prefix withString:(NSString *) str{
    return [NSString stringWithFormat:@"%@%@",prefix,str];
}

+(NSString *) addSuffix:(NSString *) suffix withString:(NSString *) str{
    return [NSString stringWithFormat:@"%@%@",str,suffix];
}

+(CGSize)getTextSizeByString:(NSString *) string byFont:(UIFont *) font{
    return [string sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
}

+(CGSize)getTextSizeByString:(NSString *) string byFont:(UIFont *) font bySize:(CGSize) size{
    return [string sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
}

+(NSArray *)splitString:(NSString*) string withStr:(NSString*)str{
    return [string componentsSeparatedByString:str];
}

+(NSString *)getSubStringWithString:(NSString *) string from:(NSInteger)start to:(NSInteger)end{
    return  [string substringWithRange:NSMakeRange(start, end)];
}

@end
