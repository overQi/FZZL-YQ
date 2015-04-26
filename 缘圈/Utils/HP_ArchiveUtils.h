//
//  HP_ArchiveUtils.h
//  缘圈
//
//  Created by 徐 阳 on 15/4/26.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HP_ArchiveUtils : NSObject
/**向NSKeyedUnarchiver存入对象*/
+ (void)setArchiveObject:(id)object forKey:(NSString *)key;

/**从NSKeyedUnarchiver获取对象*/
+ (id)getArchivedObjectForKey:(NSString *)key;
@end
