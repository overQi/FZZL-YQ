//
//  HttpManager1.h
//  HouseCat
//
//  Created by 徐 阳 on 15/4/12.
//  Copyright (c) 2015年 orangeskiller. All rights reserved.
//


#import <Foundation/Foundation.h>

/**上拉加载的行数*/
static NSInteger  const ROWNUM          = 2;
/**服务器IP地址*/
static NSString * const SERVER          = @"http://58.221.62.83/";
/**API请求地址*/
static NSString * const SERVER_API      = @"http://58.221.62.83/index.php/ioshouse/";

@interface HttpManager : NSObject

/**
 *  登陆
 *
 *  @param phone    电话号码
 *  @param password 密码
 *  @param success  成功后的回调
 *  @param failure  失败后的回调
 */
+ (void)loginWithPhone:(NSString *)phone Password:(NSString *)password
					success:(void (^)( id responseObject))success
					failure:(void (^)( NSError *error))failure;
/**
 *  注册
 *
 *  @param phone    电话号码
 *  @param password 密码
 *  @param username 客户姓名
 *  @param success  成功后的回调
 *  @param failure  失败后的回调
 */
+ (void)registerWithPhone:(NSString *)phone
				 Password:(NSString *)password
			  andUsername:(NSString *)username
			   success:(void (^)( id responseObject))success
			   failure:(void (^)( NSError *error))failure;

/**
 *  房源列表
 *
 *  @param factorarray 参数数组
 *  @param userid      用户ID
 *  @param num         当前数据条数
 *  @param count       请求数据条数
 */
+ (void)houseListWithFactorarray:(NSArray *)factorarray
						  userid:(NSInteger)userid
							 num:(NSInteger)num
						   count:(NSInteger)count
					   success:(void (^)( id responseObject))success
					   failure:(void (^)( NSError *error))failure;

/**
 *  房源信息
 *
 *  @param houseid           房源ID
 *  @param userid            用户ID
 */
+ (void)houseInfoWithHouseid:(NSInteger)houseid
					  userid:(NSInteger)userid
					 success:(void (^)( id responseObject))success
					 failure:(void (^)( NSError *error))failure;

/**
 *  关注房源
 *
 *  @param userid            用户ID
 *  @param houseid           房源ID
 */
+ (void)concernHouse:(NSInteger)houseid
					  userid:(NSInteger)userid
					 success:(void (^)( id responseObject))success
					 failure:(void (^)( NSError *error))failure;

/**
 *  搜索过滤条件(添加云客户)

 */
+ (void)searchFactorsSuccess:(void (^)( id responseObject))success
					 failure:(void (^)( NSError *error))failure;

/**
 *  手动推荐
 *
 *  @param houseid           房源ID
 *  @param phone             电话号码
 *  @param clientid          客户ID
 *  @param content           内容
 */
+ (void)recommendWithHouseid:(NSInteger)houseid
					   phone:(NSString *)phone
					clientid:(NSInteger)clientid
					 content:(NSString *)content
					 success:(void (^)( id responseObject))success
					 failure:(void (^)( NSError *error))failure;

/**
 *  自动推荐
 *
 *  @param houseid           房源ID
 *  @param userid            用户ID
 */
+ (void)autoRecommendWithHouseid:(NSInteger)houseid
						  userid:(NSInteger)userid
						 success:(void (^)( id responseObject))success
						 failure:(void (^)( NSError *error))failure;

/**
 *  云客户库列表
 *
 *  @param userid            用户ID
 */
+ (void)customerCloudListWithUserid:(NSInteger)userid
							success:(void (^)( id responseObject))success
							failure:(void (^)( NSError *error))failure;

/**
 *  云客户信息
 *
 *  @param clientid          客户ID
 */
+ (void)customerInfoWithClientid:(NSInteger)clientid
						 success:(void (^)( id responseObject))success
						 failure:(void (^)( NSError *error))failure;

/**
 *  添加云客户
 *
 *  @param userid            用户ID
 *  @param clientname        客户名称
 *  @param clientphone       客户电话
 *  @param district          意向地区
 *  @param type              意向类型
 *  @param price             意向价格
 *  @param plate             意向板块
 */
+ (void)addCustomerCloudWithUserid:(NSInteger)userid
						clientname:(NSString *)clientname
					   clientphone:(NSString *)clientphone
						  district:(NSInteger)district
							  type:(NSInteger)type
							 price:(NSInteger)price
							 plate:(NSInteger)plate
						 success:(void (^)( id responseObject))success
						 failure:(void (^)( NSError *error))failure;

/**
 *  修改云客户
 *
 *  @param clientid          客户ID
 *  @param clientname        客户名称
 *  @param clientphone       客户电话
 *  @param district          意向地区
 *  @param type              意向类型
 *  @param price             意向价格
 *  @param plate             意向板块
 */
+ (void)editCustomerCloudWithClientid:(NSInteger)clientid
						   clientname:(NSString *)clientname
						  clientphone:(NSString *)clientphone
							 district:(NSInteger)district
								 type:(NSInteger)type
								price:(NSInteger)price
								plate:(NSInteger)plate
						   success:(void (^)( id responseObject))success
						   failure:(void (^)( NSError *error))failure;

/**
 *  佣金列表
 *
 *  @param phone             电话号码
 *  @param type              佣金类型(从1开始)
 *  @param num               当前数据条数
 *  @param count             请求数据条数
 */
+ (void)commissionListWithPhone:(NSString *)phone
						   type:(NSInteger)type
							num:(NSInteger)num
						  count:(NSInteger)count
						success:(void (^)( id responseObject))success
						failure:(void (^)( NSError *error))failure;

/**
 *  佣金排行
 *
 */
+ (void)commissionChartsSuccess:(void (^)( id responseObject))success
						failure:(void (^)( NSError *error))failure;

/**
 *  资讯列表
 *
 *  @param num               当前数据量
 *  @param count             请求数据量
 */
+ (void)newsListWithNum:(NSInteger)num
				  count:(NSInteger)count
				success:(void (^)( id responseObject))success
				failure:(void (^)( NSError *error))failure;

//资讯详情
+ (void)NewsDetailWithNewsid:(NSInteger)newsid
				success:(void (^)( id responseObject))success
				failure:(void (^)( NSError *error))failure;

/**
 *  房源收藏列表
 *
 *  @param userid            用户ID
 *  @param num               当前数据条数
 *  @param count             请求数据条数
 */
+ (void)concernsListWithUserid:(NSInteger)userid
						   num:(NSInteger)num
						 count:(NSInteger)count
					 success:(void (^)( id responseObject))success
					 failure:(void (^)( NSError *error))failure;

/**
 *  意见反馈
 *
 *  @param phone             电话号码
 *  @param content           内容
 *  @param contact           联系方式
 */
+ (void)suggestionWithPhone:(NSString *)phone
					content:(NSString *)content
					contact:(NSString *)contact
				   success:(void (^)( id responseObject))success
				   failure:(void (^)( NSError *error))failure;

@end
