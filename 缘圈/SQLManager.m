//
//  SQLManager.m
//  缘圈
//
//  Created by 徐 阳 on 15/4/26.
//  Copyright (c) 2015年 iOS. All rights reserved.
//
#import "FMDB.h"
#import "UserModel.h"

#import "SQLManager.h"

@implementation SQLManager

static FMDatabaseQueue *_queue;

+ (void)initialize
{
	// 0.获得沙盒中的数据库文件名
	NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"yuanquan.sqlite"];
	
	// 1.创建队列
	_queue = [FMDatabaseQueue databaseQueueWithPath:path];
	
	// 2.创表
	[_queue inDatabase:^(FMDatabase *db) {
		
		[db executeUpdate:@"create table if not exists userModel (id integer primary key autoincrement, username text, password text, uderID text);"];
		
		
	}];
}

+ (void)addUser:(UserModel *)user
{
	[_queue inDatabase:^(FMDatabase *db) {
		// 2.存储数据
		BOOL isFinish =  [db executeUpdate:@"insert into userModel (username, password, userid) values(?, ? , ?);", user.userName, user.password, user.userID];
		if (isFinish == NO) {
			FZ_LOG(@"添加userModel到本地数据库时出错。");
		}
	}];

}


+ (void)addUsers:(NSArray *)userArray
{
	for(UserModel *user in userArray)
	{
		[self addUser:user];
	}
}

+ (NSArray *)queryUsers
{
	__block NSMutableArray *arrayM = nil;

	[_queue inDatabase:^(FMDatabase *db) {
		UserModel *user = [[UserModel alloc] init];
		
		FMResultSet *rs = nil;
		rs = [db executeQuery:@"select * from userModel;"];
		while (rs.next) {
			user.userName = [rs stringForColumn:@"userName"];
			user.password = [rs stringForColumn:@"password"];
			user.userID	  = [rs stringForColumn:@"userID"];
			user.ID = [rs longLongIntForColumn:@"id"];
			
			[arrayM addObject:user];
		}
	}];
	
	// 3.返回数据
	return arrayM;
}

+ (NSArray *)queryUsersByConstraint:(NSString *)constraint
{
	__block NSMutableArray *arrayM = nil;
	
	[_queue inDatabase:^(FMDatabase *db) {
		UserModel *user = [[UserModel alloc] init];
		
		FMResultSet *rs = nil;
		rs = [db executeQuery:[[@"select * from userModel " stringByAppendingString:constraint] stringByAppendingString:@";"]];
		while (rs.next) {
			user.userName = [rs stringForColumn:@"userName"];
			user.password = [rs stringForColumn:@"password"];
			user.userID	  = [rs stringForColumn:@"userID"];
			user.ID = [rs longLongIntForColumn:@"id"];
			
			[arrayM addObject:user];
		}
	}];
	
	// 3.返回数据
	return arrayM;
}


@end
