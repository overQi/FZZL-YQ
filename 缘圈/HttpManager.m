//
//  HttpManager.m
//  HouseCat
//
//  Created by 徐 阳 on 15/4/12.
//  Copyright (c) 2015年 orangeskiller. All rights reserved.
//

#define kSingletonManager [HttpManager sharedManager]

#import "HttpManager.h"
#import <CommonCrypto/CommonDigest.h>	//用于MD5算法
#import "HttpTool.h"
#import "MJExtension.h"


@implementation HttpManager

+ (HttpManager *)sharedManager
{
	__strong static HttpManager *sharedManager;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedManager = [[HttpManager alloc] init];
	});
	
	return sharedManager;
}

+ (void)loginWithPhone:(NSString *)phone Password:(NSString *)password success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
	//HTTP请求体；密码通过MD5加密
	NSString *body = [NSString stringWithFormat:@"phone=%@&password=%@",phone,[kSingletonManager getMd5_32Bit_String:password]];
	//打包请求体
	body = [kSingletonManager encryptbody:body];
	
	//请求体转换成字典
	NSDictionary *parameters = [kSingletonManager parametersWithHTTPBody:body];

	[HttpTool POST:[SERVER_API stringByAppendingString:@"Login"] parameters:parameters success:^(id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
		
	} failure:^(NSError *error) {
		if(failure != nil)
		{
			failure(error);
		}
	}];
}

+ (void)registerWithPhone:(NSString *)phone Password:(NSString *)password andUsername:(NSString *)username success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
	
	NSString *body = [NSString stringWithFormat:@"phone=%@&password=%@&username=%@",phone,[kSingletonManager getMd5_32Bit_String:password],username];
	body = [kSingletonManager encryptbody:body];

	NSDictionary *parameters = [kSingletonManager parametersWithHTTPBody:body];
	
	[HttpTool POST:[SERVER_API stringByAppendingString:@"Register"] parameters:parameters success:^(id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
		
	} failure:^(NSError *error) {
		if(failure != nil)
		{
			failure(error);
		}
	}];
}

+ (void)houseListWithFactorarray:(NSArray *)factorarray
						  userid:(NSInteger)userid
							 num:(NSInteger)num
						   count:(NSInteger)count
						 success:(void (^)( id responseObject))success
						 failure:(void (^)( NSError *error))failure
{
	
	NSString *body = [NSString stringWithFormat:@"housename=%@&district=%d&price=%d&type=%d&plate=%d&flag=%d&userid=%d&num=%d&count=%d",factorarray[0],[factorarray[1] integerValue],[factorarray[2] integerValue],[factorarray[3] integerValue],[factorarray[4] integerValue],[factorarray[5] integerValue],userid,num,count];

	body = [kSingletonManager encryptbody:body];
	NSDictionary *parameters = [kSingletonManager parametersWithHTTPBody:body];
	
	[HttpTool POST:[SERVER_API stringByAppendingString:@"HouseList"] parameters:parameters success:^(id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
		
	} failure:^(NSError *error) {
		if(failure != nil)
		{
			failure(error);
		}
	}];
}

+ (void)houseInfoWithHouseid:(NSInteger)houseid
					  userid:(NSInteger)userid
					 success:(void (^)( id responseObject))success
					 failure:(void (^)( NSError *error))failure
{
	
	NSString *body = [NSString stringWithFormat:@"houseid=%d&userid=%d",houseid,userid];
	
	body = [kSingletonManager encryptbody:body];
	NSDictionary *parameters = [kSingletonManager parametersWithHTTPBody:body];
	
	[HttpTool POST:[SERVER_API stringByAppendingString:@"HouseDetails"] parameters:parameters success:^(id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
		
	} failure:^(NSError *error) {
		if(failure != nil)
		{
			failure(error);
		}
	}];

}

+ (void)concernHouse:(NSInteger)houseid
			  userid:(NSInteger)userid
			 success:(void (^)( id responseObject))success
			 failure:(void (^)( NSError *error))failure
{
	NSString *body = [NSString stringWithFormat:@"userid=%d&houseid=%d",userid,houseid];

	body = [kSingletonManager encryptbody:body];
	NSDictionary *parameters = [kSingletonManager parametersWithHTTPBody:body];
	
	[HttpTool POST:[SERVER_API stringByAppendingString:@"Attention"] parameters:parameters success:^(id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
		
	} failure:^(NSError *error) {
		if(failure != nil)
		{
			failure(error);
		}
	}];
}

+ (void)searchFactorsSuccess:(void (^)( id responseObject))success
					 failure:(void (^)( NSError *error))failure
{
	NSString *body = @"";
	
	body = [kSingletonManager encryptbody:body];
	NSDictionary *parameters = [kSingletonManager parametersWithHTTPBody:body];
	
	[HttpTool POST:[SERVER_API stringByAppendingString:@"SearchFactors"] parameters:parameters success:^(id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
		
	} failure:^(NSError *error) {
		if(failure != nil)
		{
			failure(error);
		}
	}];

}

+ (void)recommendWithHouseid:(NSInteger)houseid
					   phone:(NSString *)phone
					clientid:(NSInteger)clientid
					 content:(NSString *)content
					 success:(void (^)( id responseObject))success
					 failure:(void (^)( NSError *error))failure
{
	
	NSString *body = [NSString stringWithFormat:@"houseid=%d&phone=%@&clientid=%d&content=%@",houseid,phone,clientid,content];
	
	body = [kSingletonManager encryptbody:body];
	NSDictionary *parameters = [kSingletonManager parametersWithHTTPBody:body];
	
	[HttpTool POST:[SERVER_API stringByAppendingString:@"Recommend"] parameters:parameters success:^(id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
		
	} failure:^(NSError *error) {
		if(failure != nil)
		{
			failure(error);
		}
	}];
}

+ (void)autoRecommendWithHouseid:(NSInteger)houseid
						  userid:(NSInteger)userid
						 success:(void (^)( id responseObject))success
						 failure:(void (^)( NSError *error))failure
{
	NSString *body = [NSString stringWithFormat:@"houseid=%d&userid=%d",houseid,userid];
	
	body = [kSingletonManager encryptbody:body];
	NSDictionary *parameters = [kSingletonManager parametersWithHTTPBody:body];
	
	[HttpTool POST:[SERVER_API stringByAppendingString:@"AutomaticRecommend"] parameters:parameters success:^(id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
		
	} failure:^(NSError *error) {
		if(failure != nil)
		{
			failure(error);
		}
	}];

}

+ (void)customerCloudListWithUserid:(NSInteger)userid
							success:(void (^)( id responseObject))success
							failure:(void (^)( NSError *error))failure
{
	NSString *body = [NSString stringWithFormat:@"userid=%d",userid];
	
	body = [kSingletonManager encryptbody:body];
	NSDictionary *parameters = [kSingletonManager parametersWithHTTPBody:body];
	
	[HttpTool POST:[SERVER_API stringByAppendingString:@"ListClient"] parameters:parameters success:^(id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
		
	} failure:^(NSError *error) {
		if(failure != nil)
		{
			failure(error);
		}
	}];
}

+ (void)customerInfoWithClientid:(NSInteger)clientid
						 success:(void (^)( id responseObject))success
						 failure:(void (^)( NSError *error))failure
{
	NSString *body = [NSString stringWithFormat:@"clientid=%d",clientid];
	
	body = [kSingletonManager encryptbody:body];
	NSDictionary *parameters = [kSingletonManager parametersWithHTTPBody:body];
	
	[HttpTool POST:[SERVER_API stringByAppendingString:@"SeekClient"] parameters:parameters success:^(id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
		
	} failure:^(NSError *error) {
		if(failure != nil)
		{
			failure(error);
		}
	}];
}

+ (void)addCustomerCloudWithUserid:(NSInteger)userid
						clientname:(NSString *)clientname
					   clientphone:(NSString *)clientphone
						  district:(NSInteger)district
							  type:(NSInteger)type
							 price:(NSInteger)price
							 plate:(NSInteger)plate
						   success:(void (^)( id responseObject))success
						   failure:(void (^)( NSError *error))failure
{
	NSString *body = [NSString stringWithFormat:@"userid=%d&clientname=%@&clientphone=%@&district=%d&type=%d&price=%d&plate=%d",userid,clientname,clientphone,district,type,price,plate];
	
	body = [kSingletonManager encryptbody:body];
	NSDictionary *parameters = [kSingletonManager parametersWithHTTPBody:body];
	
	[HttpTool POST:[SERVER_API stringByAppendingString:@"AddClient"] parameters:parameters success:^(id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
		
	} failure:^(NSError *error) {
		if(failure != nil)
		{
			failure(error);
		}
	}];
}

+ (void)editCustomerCloudWithClientid:(NSInteger)clientid
						   clientname:(NSString *)clientname
						  clientphone:(NSString *)clientphone
							 district:(NSInteger)district
								 type:(NSInteger)type
								price:(NSInteger)price
								plate:(NSInteger)plate
						   success:(void (^)( id responseObject))success
						   failure:(void (^)( NSError *error))failure
{
	
	NSString *body = [NSString stringWithFormat:@"clientid=%d&clientname=%@&clientphone=%@&district=%d&type=%d&price=%d&plate=%d",clientid,clientname,clientphone,district,type,price,plate];
	
	body = [kSingletonManager encryptbody:body];
	NSDictionary *parameters = [kSingletonManager parametersWithHTTPBody:body];
	
	[HttpTool POST:[SERVER_API stringByAppendingString:@"EditClient"] parameters:parameters success:^(id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
		
	} failure:^(NSError *error) {
		if(failure != nil)
		{
			failure(error);
		}
	}];
}

+ (void)commissionListWithPhone:(NSString *)phone
						   type:(NSInteger)type
							num:(NSInteger)num
						  count:(NSInteger)count
						success:(void (^)( id responseObject))success
						failure:(void (^)( NSError *error))failure
{
	NSString *body = [NSString stringWithFormat:@"phone=%@&type=%d&num=%d&count=%d",phone,type,num,count];
	
	body = [kSingletonManager encryptbody:body];
	NSDictionary *parameters = [kSingletonManager parametersWithHTTPBody:body];
	
	[HttpTool POST:[SERVER_API stringByAppendingString:@"Commission"] parameters:parameters success:^(id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
		
	} failure:^(NSError *error) {
		if(failure != nil)
		{
			failure(error);
		}
	}];
}

+ (void)commissionChartsSuccess:(void (^)( id responseObject))success
						failure:(void (^)( NSError *error))failure
{
	NSString *body = @"";
	
	body = [kSingletonManager encryptbody:body];
	NSDictionary *parameters = [kSingletonManager parametersWithHTTPBody:body];
	
	[HttpTool POST:[SERVER_API stringByAppendingString:@"RankingCommission"] parameters:parameters success:^(id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
		
	} failure:^(NSError *error) {
		if(failure != nil)
		{
			failure(error);
		}
	}];
}

+ (void)newsListWithNum:(NSInteger)num
				  count:(NSInteger)count
				success:(void (^)( id responseObject))success
				failure:(void (^)( NSError *error))failure
{
	
	NSString *body = [NSString stringWithFormat:@"num=%d&count=%d",num,count];
	
	body = [kSingletonManager encryptbody:body];
	NSDictionary *parameters = [kSingletonManager parametersWithHTTPBody:body];
	
	[HttpTool POST:[SERVER_API stringByAppendingString:@"NewsList"] parameters:parameters success:^(id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
		
	} failure:^(NSError *error) {
		if(failure != nil)
		{
			failure(error);
		}
	}];
}

+ (void)NewsDetailWithNewsid:(NSInteger)newsid
					 success:(void (^)( id responseObject))success
					 failure:(void (^)( NSError *error))failure
{
	
	NSString *body = [NSString stringWithFormat:@"newsid=%d",newsid];
	
	body = [kSingletonManager encryptbody:body];
	NSDictionary *parameters = [kSingletonManager parametersWithHTTPBody:body];
	
	[HttpTool POST:[SERVER_API stringByAppendingString:@"NewDetails"] parameters:parameters success:^(id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
		
	} failure:^(NSError *error) {
		if(failure != nil)
		{
			failure(error);
		}
	}];
}

+ (void)concernsListWithUserid:(NSInteger)userid
						   num:(NSInteger)num
						 count:(NSInteger)count
					   success:(void (^)( id responseObject))success
					   failure:(void (^)( NSError *error))failure
{
	NSString *body = [NSString stringWithFormat:@"userid=%d&num=%d&count=%d",userid,num,count];
	
	body = [kSingletonManager encryptbody:body];
	NSDictionary *parameters = [kSingletonManager parametersWithHTTPBody:body];
	
	[HttpTool POST:[SERVER_API stringByAppendingString:@"AttentionList"] parameters:parameters success:^(id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
		
	} failure:^(NSError *error) {
		if(failure != nil)
		{
			failure(error);
		}
	}];
}

+ (void)suggestionWithPhone:(NSString *)phone
					content:(NSString *)content
					contact:(NSString *)contact
					success:(void (^)( id responseObject))success
					failure:(void (^)( NSError *error))failure
{
	
	NSString *body = [NSString stringWithFormat:@"phone=%@&content=%@&contact=%@",phone,content,contact];

	body = [kSingletonManager encryptbody:body];
	NSDictionary *parameters = [kSingletonManager parametersWithHTTPBody:body];
	
	[HttpTool POST:[SERVER_API stringByAppendingString:@"Suggestion"] parameters:parameters success:^(id responseObject) {
		if(success != nil)
		{
			success(responseObject);
		}
		
	} failure:^(NSError *error) {
		if(failure != nil)
		{
			failure(error);
		}
	}];
}
#pragma mark --辅助函数
/**
 *  将HTTP的string类型参数转换成字典
 *
 *  @param body phone=1234567&password=321
 *
 *  @return @{@"phone":@"1234567",@"password":@"321"}
 */
- (NSDictionary *)parametersWithHTTPBody:(NSString *)body
{
	NSArray *array = [body componentsSeparatedByString:@"&"];
	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
	for(NSString *str in array)
	{
		NSString *value = [str componentsSeparatedByString:@"="][1];
		NSString *key   = [str componentsSeparatedByString:@"="][0];
		[parameters setValue:value forKey:key];
	}
	return parameters;
}

/**!
 *  对HTTP请求参数(body)后追加当前时间戳和签名(sig)
 *
 *  @param body HTTP请求参数
 *  timeStamp 时间戳
 *  sig = “时间戳+&nado”生成MD5签名码
 *  @return 经过MD5签名的HTTP请求参数
 */
- (NSString *)encryptbody:(NSString *)body {
	NSDate *date = [NSDate date];
	NSTimeInterval interval = [date timeIntervalSince1970];
	NSString *timeStamp = [NSString stringWithFormat:@"%.0f", interval];
	
	NSString *md5string;
	NSString *encryptedbody;
	if ([body isEqual:@""]) {
		md5string = [body stringByAppendingFormat:@"timestamp=%@&nado",timeStamp];
		encryptedbody = [body stringByAppendingFormat:@"timestamp=%@&sig=%@",timeStamp,[self getMd5_32Bit_String:md5string]];
	}
	else {
		md5string = [body stringByAppendingFormat:@"&timestamp=%@&nado",timeStamp];
		encryptedbody = [body stringByAppendingFormat:@"&timestamp=%@&sig=%@",timeStamp,[self getMd5_32Bit_String:md5string]];
	}
	
	return encryptedbody;
}

/*!
 * MD5 加密算法
 */
- (NSString *)getMd5_32Bit_String:(NSString *)srcString {
	const char *cStr = [srcString UTF8String];
	unsigned char digest[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, strlen(cStr), digest );
	NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
	for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
		[result appendFormat:@"%02x", digest[i]];
	
	return result;
}
@end
