//
//  HP_ArchiveUtils.m
//  缘圈
//
//  Created by 徐 阳 on 15/4/26.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "HP_ArchiveUtils.h"

@implementation HP_ArchiveUtils
+ (void)setArchiveObject:(id<NSCoding>)object forKey:(NSString *)key
{
	NSMutableString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	path = [[path stringByAppendingPathComponent:key] mutableCopy];
	path = [[path stringByAppendingString:@".archiver"] mutableCopy];
	[NSKeyedArchiver archiveRootObject:object toFile:path];
	
}

+ (id)getArchivedObjectForKey:(NSString *)key
{
	NSMutableString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	path                  = [[path stringByAppendingPathComponent:key] mutableCopy];
	path                  = [[path stringByAppendingString:@".archiver"] mutableCopy];
	
	return  [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}
@end
