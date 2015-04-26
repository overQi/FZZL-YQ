//
//  UserModel.m
//  缘圈
//
//  Created by 徐 阳 on 15/4/26.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
- (id)initWithCoder:(NSCoder *)aDecoder
{
	if( self = [super init])
	{
		self.userName = [aDecoder decodeObjectForKey:@"userName"];
		self.password = [aDecoder decodeObjectForKey:@"password"];
		self.userID   = [aDecoder decodeObjectForKey:@"userID"];
		self.ID       = [aDecoder decodeInt64ForKey:@"ID"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:self.userName forKey:@"userName"];
	[aCoder encodeObject:self.password forKey:@"password"];
	[aCoder encodeObject:self.userID forKey:@"userID"];
	[aCoder encodeInt64 :self.ID forKey:@"ID"];
}
@end
