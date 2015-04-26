//
//  HttpTool.h
//  HouseCat
//
//  Created by 徐 阳 on 15/4/12.
//  Copyright (c) 2015年 orangeskiller. All rights reserved.
//
/*封装整个项目的GET/POST请求*/

#define kTimeoutInterval 10.0f

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject
/**
 *  发送一个GET请求
 *
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param success    成功后的回调
 *  @param failure    失败后的回调
 */
+ (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
	success:(void (^)( id responseObject))success
	failure:(void (^)( NSError *error))failure;

/**
 *  发送一个post请求
 *
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param success    成功后的回调
 *  @param failure    失败后的回调
 */
+ (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
	 success:(void (^)( id responseObject))success
	 failure:(void (^)( NSError *error))failure;

/**
 *  发送一个post请求并且发送文件,文件需要使用HP_HTTP_FormData类封装
 *
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param datas      Data类型的文件
 *  @param success    成功后的回调
 *  @param failure    失败后的回调
 */
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
constructingBodyWithFormDataArray:(NSArray *)formDataArray
	 success:(void (^)( id responseObject))success
	 failure:(void (^)( NSError *error))failure;

@end

/*HTTPTool使用POST添加文件时使用的文件类*/
@interface FormData : NSObject
/**请求参数名*/
@property (nonatomic, copy, readwrite) NSString *name;
/**保存到服务器的文件名*/
@property (nonatomic, copy, readwrite) NSString *fileName;
/**文件类型*/
@property (nonatomic, copy, readwrite) NSString *mimeType;
/**二进制数据*/
@property (nonatomic, strong, readwrite) NSData *data;
@end