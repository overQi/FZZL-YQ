//
//  HttpTool.m
//  HouseCat
//
//  Created by 徐 阳 on 15/4/12.
//  Copyright (c) 2015年 orangeskiller. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

@implementation HttpTool

+ (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
	success:(void (^)( id responseObject))success
	failure:(void (^)( NSError *error))failure
{
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	
	// 设置超时时间
	[manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
	manager.requestSerializer.timeoutInterval = kTimeoutInterval;
	[manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
	
	[manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if(failure != nil)
		{
			failure(error);
			FZ_LOG(@"网络请求错误：%@",error);
			[MBProgressHUD showError:@"网络不给力啊"];
		}
	}];
	
}

+ (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
	 success:(void (^)( id responseObject))success
	 failure:(void (^)( NSError *error))failure;
{
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	
	// 设置超时时间
	[manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
	manager.requestSerializer.timeoutInterval = kTimeoutInterval;
	[manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
	
	
	[manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if(failure != nil)
		{
			failure(error);
			FZ_LOG(@"网络请求错误：%@",error);
			[MBProgressHUD showError:@"网络不给力啊"];
		}
	}];
}

+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
constructingBodyWithFormDataArray:(NSArray *)formDataArray
	 success:(void (^)(id responseObject))success
	 failure:(void (^)(NSError *error))failure
{
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	
	// 设置超时时间
	[manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
	manager.requestSerializer.timeoutInterval = kTimeoutInterval;
	[manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
	
	
	[manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
		
		for (FormData *data in formDataArray) {
			[formData appendPartWithFileData:data.data name:data.name fileName:data.fileName mimeType:data.mimeType];
		}
	} success:^(AFHTTPRequestOperation *operation, id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if(failure != nil)
		{
			failure(error);
			FZ_LOG(@"网络请求错误：%@",error);
			[MBProgressHUD showError:@"网络不给力啊"];
		}
	}];
}
@end


@implementation FormData

@end
