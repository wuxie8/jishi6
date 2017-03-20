//
//  NetWorkManager.h
//  xiaoyixiu
//
//  Created by hanzhanbing on 16/6/14.
//  Copyright © 2016年 柯南. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NetWorkManager : AFHTTPSessionManager

+ (instancetype)sharedManager;
#pragma mark - 接口请求(返回Data数据流)

/**
 *  无弹框POST请求(只请求data数据流，具体操作放在使用的地方)
 *
 *  @param name       接口名称
 *  @param parameters 传参
 *  @param success    成功回调
 *  @param failure    失败回调
 *
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)postData:(NSString *)name
                        parameters:(NSDictionary *)parameters
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  无弹框GET请求(只请求data数据流，具体操作放在使用的地方)
 *
 *  @param name       接口名称
 *  @param parameters 传参
 *  @param success    成功回调
 *  @param failure    失败回调
 *
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getData:(NSString *)name
                       parameters:(NSDictionary *)parameters
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

#pragma mark - 接口请求(返回JSON数据)

/**
 *  POST请求(弹框)
 *
 *  @param name       接口名称
 *  @param parameters 传参
 *  @param success    成功回调
 *  @param failure    失败回调
 *
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)postJSON:(NSString *)name
                        parameters:(NSDictionary *)parameters
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  GET请求(弹框)
 *
 *  @param name       接口名称
 *  @param parameters 传参
 *  @param success    成功回调
 *  @param failure    失败回调
 *
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getJSON:(NSString *)name
                       parameters:(NSDictionary *)parameters
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  POST请求(无弹框)
 *
 *  @param name       接口名称
 *  @param parameters 传参
 *  @param success    成功回调
 *  @param failure    失败回调
 *
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)postNoTipJSON:(NSString *)name
                        parameters:(NSDictionary *)parameters
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  GET请求(无弹框)
 *
 *  @param name       接口名称
 *  @param parameters 传参
 *  @param success    成功回调
 *  @param failure    失败回调
 *
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getNoTipJSON:(NSString *)name
                       parameters:(NSDictionary *)parameters
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;



//手环请求方法
- (NSURLSessionDataTask *)postNoTipJSONBracelet:(NSString *)name
                             parameters:(NSDictionary *)parameters
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


- (NSURLSessionDataTask *)getNoTipJSONBracelet:(NSString *)name
                            parameters:(NSDictionary *)parameters
                               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


@end

